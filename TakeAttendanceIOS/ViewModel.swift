//
//  ViewModel.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 5.05.2024.
//

import Foundation
import SwiftUI

class StudentAddViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private var apiURL: URL // API URL'sini burada belirtin

    init(apiURL: URL) {
        self.apiURL = apiURL
    }

    func addStudent(name: String, image: UIImage?, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let imageData = image?.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Resim seçimi başarısız oldu."])))
            return
        }

        isLoading = true

        // API isteği hazırlık
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"

        // Multi-part form verileri oluşturma
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        // Metin alanını ekleme
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"name\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(name)\r\n".data(using: .utf8)!)

        // Resim dosyasını ekleme
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(name).jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)

        // Form verilerini kapatma
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body

        // URLSession ile API isteği gönderme
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    completion(.failure(error))
                    self.errorMessage = error.localizedDescription
                    return
                }

                // Başarılı yanıt alındığında
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    completion(.success(()))
                } else {
                    let errorMessage = "Sunucudan geçersiz yanıt alındı."
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                    self.errorMessage = errorMessage
                }
            }
        }

        task.resume()
    }
}




struct dataType: Identifiable, Hashable{
    var id: String
    var name : String
    var image : String
    
}



class SendData: ObservableObject{
    @Published var datas = [dataType]()
}

