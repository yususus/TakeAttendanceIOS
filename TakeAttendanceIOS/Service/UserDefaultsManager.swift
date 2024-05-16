//
//  UserDefaultsManager.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 14.05.2024.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager() // Singleton örnek

    private let userDefaults = UserDefaults.standard
    private let studentNameKey = "studentName"
    private let photoPathKey = "photoPath"

    func saveStudentData(name: String, photoPath: String) {
        userDefaults.set(name, forKey: studentNameKey)
        userDefaults.set(photoPath, forKey: photoPathKey)
        userDefaults.synchronize() 
    }

    func getStudentData() -> (name: String?, photoPath: String?) {
        let name = userDefaults.string(forKey: studentNameKey)
        let photoPath = userDefaults.string(forKey: photoPathKey)
        return (name, photoPath)
    }
}
