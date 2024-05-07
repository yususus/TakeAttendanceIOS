//
//  StudentTaken.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 7.05.2024.
//

import SwiftUI

struct StudentTaken: View {
    
    @StateObject var recieveData = RecieveData()
    var body: some View {
        VStack{
            Button(action: {}, label: {
                Image(systemName: "person.crop.square.badge.camera")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .foregroundStyle(Color.green.opacity(0.8))
            })
            Button(action: {}, label: {
                Text("Scan")
                    .frame(width: 100,height: 50)
                    .font(.title3)
                    .padding()
                    .frame(width: 75, height: 35)
                    .background(Color.secondary)
                    .foregroundColor(Color.white)
                    .cornerRadius(4)
            })
            
            ScrollView{
                //TakenStudent(student: "yusuf")
                ForEach(recieveData.datas, id: \.self) { item in
                    TakenStudent(student: item.name)
                                .padding()
                }
            }
        }
        
    }
}

#Preview {
    StudentTaken()
}
