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


class GetDataBase : ObservableObject {
    @Published var datas = [dataType]()
    
    func fetchData(for category: String) {
        guard let url = URL(string: Config.getPerson) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned from API")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(PersonAdded.self, from: data)
                DispatchQueue.main.async {
                    self.datas = response.articles.map {
                        dataType(
                            id: $0.publishedAt ?? "",
                            number: $0.number ?? "",
                            image: $0.urlToImage ?? ""
                        )
                    }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}


