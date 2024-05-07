//
//  ViewModel.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 5.05.2024.
//

import Foundation
import SwiftUI






struct dataType: Identifiable, Hashable{
    var id: String
    var name : String
    var image : String
    
}



class SendData: ObservableObject{
    @Published var datas = [dataType]()
}


class RecieveData: ObservableObject{
    @Published var datas = [dataType]()
}

