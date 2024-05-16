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

struct PersonInformation: Decodable {
    let number: String?
    let urlToImage: String?
    let publishedAt: String?
}
    
struct dataType: Identifiable, Hashable{
    var id: String
    var number : String
    var image : String
    
}

//  






