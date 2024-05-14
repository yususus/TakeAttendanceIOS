//
//  StudentTaken.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 7.05.2024.
//

import SwiftUI

struct StudentTaken: View {
    
    @State private var showCamera = false
    @State private var attendance: UIImage? = nil
    
    @StateObject var recieveData = RecieveData()
    var body: some View {
        NavigationStack {
            VStack{
                HStack {
                    Button(action: {
                        showCamera = true
                    }, label: {
                        Image(systemName: "person.crop.square.badge.camera")
                            .resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .foregroundStyle(Color.white)
                    }).frame(width: 120, height: 120)
                        .background(Color(uiColor: UIColor(hex: "7AB2B2"))).clipShape(.rect(cornerRadius: 10, style: .continuous)).shadow(radius: 10)
                    Divider().frame(height: 100).frame(minWidth: 0.5).background(Color.black)
                    Spacer()
                    Button(action: {}, label: {
                        Text("Start Scan")
                            .font(.title3)
                            .padding()
                            .frame(width: 140, height: 45)
                            .foregroundColor(Color.white)
                            .background(Color(uiColor: UIColor(hex: "4D869C")))
                            .cornerRadius(4)
                    }).shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 2)
                }.padding(.horizontal, 40)
                    .frame(width: 400)
                    
                    
                Divider().frame(width: 350).frame(minHeight: 2).background(Color.black)
                
                ScrollView{
                    //TakenStudent(student: "yusuf")
                    ForEach(recieveData.datas, id: \.self) { item in
                        TakenStudent(student: "")
                                    .padding()
                    }
                }
            }.sheet(isPresented: $showCamera) {
                // Kamera picker'ını gösterin
                ImagePicker(selectedImage: $attendance)
        }
            .navigationTitle("Yoklama Al")
        }
        
    }
}

#Preview {
    StudentTaken()
}
