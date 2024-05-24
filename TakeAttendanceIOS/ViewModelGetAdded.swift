//
//  ViewModel.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 5.05.2024.
//

import Foundation
import SwiftUI

//get database for added student
struct PersonAdded: Decodable {
    let articles: [PersonInformation]
}

struct PersonInformation: Codable, Identifiable {
    let id: Int
    let no, imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, no
        case imageURL = "imageUrl"
    }
}





//  






