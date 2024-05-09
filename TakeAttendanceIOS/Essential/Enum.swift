//
//  Enum.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 5.05.2024.
//

import Foundation
import SwiftUI

enum ErrorMessage: Int  {
    case emptyFields = 1
    case invalidEmail = 2
    case shortPassword = 3
    case passwordsNotMatch = 4
    case wrongPassword = 17004
    case confidentialityAgreement = 5
    case registeredMail = 17007
    case verifiedError = 10
    case usernameError = 12
    
    
    var description: String {
        switch self {
        case .emptyFields:
            return "Lütfen tüm alanları doldurunuz. "
        case .invalidEmail:
            return "Geçersiz e-posta adresi. Mail adresinizin edu.tr uzantılı mailiniz olduğundan emin olun."
        case .shortPassword:
             return "Şifre en az 6 karakterli olmalı "
        case .wrongPassword:
            return "Yanlış şifre. Lütfen doğru şifreyi girin."
        case .passwordsNotMatch:
            return "Şifreler Eşleşmiyor"
        case .confidentialityAgreement:
            return "Gizlilik sözleşmesini onaylanıyız"
        case .registeredMail:
            return "Mail adresi zaten kayıtlı"
        case.verifiedError:
            return "Giriş yapmak için önce mailinizi doğrulayınız."
        case.usernameError:
            return "Kullanıcı adı zaten kayıtlı"
        }
    }
}


class CustomTextFieldPriv {
    @ViewBuilder
    static func CustomTextField(text: Binding<String>, placeHolder: String) -> some View{
        VStack{
            ZStack(alignment: .leading) {
                if text.wrappedValue.isEmpty {
                    Text(placeHolder)
                        .foregroundColor(.black.opacity(0.6)).padding()
                }
                TextField("", text: text)
                    .foregroundColor(.black).padding()
            }
            
        }.frame(width: 250, height: 50)
            .background(Color.green.opacity(0.3))
            .clipShape(.rect(cornerRadius: 10))
    }
}
