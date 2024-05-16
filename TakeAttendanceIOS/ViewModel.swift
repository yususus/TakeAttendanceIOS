//
//  ViewModel.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 5.05.2024.
//

import Foundation
import SwiftUI






class SendData: ObservableObject {
    @Published var datas: [StudentData] = [] // Öğrenci verilerini tutacak özellik

    // Öğrenci ekleme işlemi
    func addStudent(name: String, photoPath: String) {
        let newStudent = StudentData(name: name, image: photoPath)
        datas.append(newStudent)
    }
    
    // UserDefaults'tan kaydedilen verileri döndüren fonksiyon
        func getStoredStudentData() -> StudentData? {
            // UserDefaults'tan kaydedilen verileri alma
            let (storedName, storedPhotoPath) = UserDefaultsManager.shared.getStudentData()
            
            // Eğer veriler varsa StudentData yapısına dönüştürerek döndür
            if let name = storedName, let photoPath = storedPhotoPath {
                return StudentData(name: name, image: photoPath)
            } else {
                return nil // Veri yoksa nil döndür
            }
        }
}

struct StudentData: Identifiable, Hashable {
    var id = UUID() // Öğrenci kimliği
    var name: String // Öğrenci adı
    var image: String // Öğrenci fotoğrafı yolu
}


class RecieveData: ObservableObject{
    @Published var datas = [StudentData]()
}

