//
//  ServiceGetScanPhoto.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 16.05.2024.
//

import Foundation
import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import Combine


class GetScanPhoto: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var students: [Student] = []
    
    private let apiURL = URL(string: Config.ScanPerson)!
    
    func scanStudent(image: UIImage?, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let imageData = image?.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Resim seçimi başarısız oldu."])))
            return
        }
        
        isLoading = true
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        let fileName = UUID().uuidString + ".jpg"
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    let errorMessage = "Geçersiz yanıt türü alındı."
                    self.errorMessage = errorMessage
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                    return
                }
                
                guard (200..<300).contains(httpResponse.statusCode), let data = data else {
                    let errorMessage = "HTTP durumu \(httpResponse.statusCode): İstek başarısız."
                    self.errorMessage = errorMessage
                    completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                    return
                }
                
                do {
                    let students = try JSONDecoder().decode([Student].self, from: data)
                    print("JSON yanıtı: \(students)")
                    if !students.isEmpty {
                        self.students = students
                        completion(.success(()))
                    } else {
                        let errorMessage = " Öğrenci verileri eksik veya boş."
                        self.errorMessage = errorMessage
                        completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                    }
                } catch let decodingError {
                    let errorMessage = "JSON çözümlemesi başarısız oldu: \(decodingError)"
                    self.errorMessage = errorMessage
                    completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                }
            }
        }
        task.resume()
    }
}


