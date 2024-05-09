//
//  StudentAdd.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 5.05.2024.
//

import SwiftUI


struct StudentAdd: View {
    @State private var showCameraPicker = false
    @State private var student: UIImage? = nil
    @State var textName: String
    
    @StateObject var sendData = SendData()
    @StateObject var serviceSend = SendDatabase()
    
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    Button(action: {
                        showCameraPicker = true
                    }, label: {
                        Image(systemName: "camera.viewfinder")
                            .resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 100,height: 100)
                            .foregroundStyle(Color.black)
                    })
                    
                    CustomTextFieldPriv.CustomTextField(text: $textName, placeHolder: "Öğrenci adını giriniz")
                }.padding(10)
                
                
                Button(action: {
                    addStudentData()
                }, label: {
                    Text("Ekle")
                        .font(.title3)
                        .padding()
                        .frame(width: 75, height: 35)
                        .background(Color.secondary)
                        .foregroundColor(Color.white)
                        .cornerRadius(4)
                    
                }).shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 2)
                Spacer()
                
                VStack{
                    ScrollView{
                        ForEach(sendData.datas, id: \.self) { item in
                            AddedStudent(name: item.name)
                                .padding()
                        }
                        
                    }
                }.padding()
                
            }.sheet(isPresented: $showCameraPicker) {
                // Kamera picker'ını gösterin
                ImagePicker(selectedImage: $student)
            }
            .navigationTitle("Öğrenci Ekle")
        }
        
    }
    
    
    // Öğrenci verilerini sunucuya gönderme işlemi
    func addStudentData() {
        // Öğrenci adını ve çekilen resmi sunucuya gönder
        serviceSend.addStudent(name: textName, image: student) { result in
            switch result {
            case .success:
                print("Öğrenci başarıyla eklendi")
            case .failure(let error):
                print("Hata: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    StudentAdd(textName: "")
}
