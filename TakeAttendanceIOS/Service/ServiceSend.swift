//
//  ServiceSend.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 7.05.2024.
//

import Foundation
import SwiftUI
import Combine
import UIKit

class SendDatabase: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var apiURL: URL {
        return URL(string: Config.apiUrl)!
    }
    
    func addStudent(name: String, image: UIImage?, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let imageData = image?.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Resim seçimi başarısız oldu."])))
            return
        }
        
        isLoading = true
        
        // name parametresini URL yoluna ekleme
        let apiUrlWithPath = apiURL.appendingPathComponent(name)
        
        // API isteği hazırlık
        var request = URLRequest(url: apiUrlWithPath)
        request.httpMethod = "POST"

        // Multi-part form verileri oluşturma
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        // Benzersiz bir dosya adı oluşturma
        let fileName = UUID().uuidString + ".jpg"

        // Resim dosyasını ekleme
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)

        // Form verilerini kapatma
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        // HTTP body'yi isteğe ekleme
        request.httpBody = body

        // URLSession ile API isteği gönderme
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                // Hata varsa işlemi tamamla
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(.failure(error))
                    return
                }
                
                // Yanıtın HTTPURLResponse olduğunu kontrol et
                if let response = response as? HTTPURLResponse {
                    // Durum kodunu kontrol et
                    if response.statusCode == 200 {
                        // Yanıt içeriğini kontrol et
                        if let data = data {
                            do {
                                // JSON çözümleme
                                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                                
                                // Sunucunun döndürdüğü `success` değerini kontrol et
                                if let success = jsonResponse?["success"] as? Bool {
                                    // Success değerini yazdır
                                    print("Success: \(success)")
                                    
                                    if success {
                                        // İşlem başarılıysa
                                        completion(.success(()))
                                    } else {
                                        // İşlem başarısızsa genel bir hata mesajı göster
                                        let errorMessage = "İşlem başarısız oldu."
                                        self.errorMessage = errorMessage
                                        completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                                    }
                                } else {
                                    // `success` anahtarı yoksa genel bir hata mesajı
                                    let errorMessage = "Sunucudan geçersiz yanıt alındı."
                                    self.errorMessage = errorMessage
                                    completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                                }
                            } catch {
                                // JSON çözümlemesi başarısız olursa
                                let errorMessage = "JSON çözümlemesi başarısız oldu."
                                self.errorMessage = errorMessage
                                completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                            }
                        } else {
                            // Veri yoksa veya başka bir hata varsa
                            let errorMessage = "Sunucudan geçersiz yanıt alındı."
                            self.errorMessage = errorMessage
                            completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                        }
                    } else {
                        // Başarısız yanıt durumunda genel bir hata mesajı
                        let errorMessage = "HTTP durumu \(response.statusCode): İstek başarısız."
                        self.errorMessage = errorMessage
                        completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                    }
                }
            }
        }
        task.resume()
    }

}

