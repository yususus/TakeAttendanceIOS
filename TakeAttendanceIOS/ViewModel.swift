//
//  ViewModel.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 5.05.2024.
//

import Foundation


@MainActor
class ViewModel:ObservableObject{
    @Published var textName = ""
    
    
    
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    
    /*
    func addtoDatabase() async -> Bool{
        guard textName.isEmpty else{
            if let errorMessage = ErrorMessage(rawValue: 1){
                self.showAlert = true
                self.alertTitle = "Hata!!"
                self.alertMessage = "Beklenmedik bir hata oluştu"
                print("Beklenmedik bir hata oluştu")
            }
            return false
        }
    }
     */
}
