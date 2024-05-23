//
//  ServiceRecieve.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 9.05.2024.
//

import Foundation


import Foundation
import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import Combine

class GetDataBase: ObservableObject {
    @Published var datas = [PersonInformation]()
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let apiURL = URL(string: "http://35.193.152.202:8000/student")!
    
    func fetchData() {
        isLoading = true
        errorMessage = nil
        
        let task = URLSession.shared.dataTask(with: apiURL) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data returned from server"
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode([PersonInformation].self, from: data)
                    self.datas = response
                } catch {
                    self.errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                }
            }
        }
        
        task.resume()
    }
}


