//
//  TakeStudent.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 7.05.2024.
//

import SwiftUI

struct TakenStudent: View {
    var student: String
    
    
    var body: some View {
        VStack{
            HStack {
                Text(student)
                Spacer()
                Image(systemName: "checkmark.circle").resizable().aspectRatio(contentMode: .fit).frame(height: 30).foregroundStyle(Color.green)
                //Image(systemName: "wrongwaysign").resizable().aspectRatio(contentMode: .fit).frame(height: 30).foregroundStyle(Color.red)
                //checkmark.circle
                //wrongwaysign
            }.padding().frame(width: 350, height: 50)
                .background(Color.cyan.opacity(0.25))
                .clipShape(.rect(cornerRadius: 10))
        }
        
    }
}

#Preview {
    TakenStudent(student: "Yusuf AYDIN")
}
