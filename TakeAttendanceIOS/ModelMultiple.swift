//
//  ModelMultiple.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 24.05.2024.
//

import Foundation
import SwiftUI


struct Student: Codable, Identifiable {
    let id: Int
    let no: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, no
        case imageUrl = "imageUrl"
    }
}
