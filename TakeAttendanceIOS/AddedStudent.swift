//
//  AddedStudent.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 5.05.2024.
//

import SwiftUI

struct AddedStudent: View {
    var name: String
    
    
    var body: some View {
        VStack{
            HStack {
                Text(name).frame(width: 250,height: 75).fontDesign(.serif).font(.title3)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "trash.fill").foregroundStyle(Color.red).font(.title2)
                    
                })
            }
            
            
        }.frame(width: 350, height: 100)
            .background(Color.gray.opacity(0.4))
            .clipShape(.rect(cornerRadius: 10))
        
    }
}

#Preview {
    AddedStudent(name: "Yusuf aydın")
}
