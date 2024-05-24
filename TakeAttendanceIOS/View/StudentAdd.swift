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
    
    
    @StateObject var serviceSend = SendDatabase()
    @StateObject var getData = GetDataBase()
    
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    Button(action: {
                        showCameraPicker = true
                    }, label: {
                        Image(systemName: "camera.viewfinder")
                            .resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 75,height: 75)
                            .foregroundStyle(Color.black)
                    }).frame(width: 110, height: 100)
                        .background(Color(uiColor: UIColor(hex: "7AB2B2"))).clipShape(.rect(cornerRadius: 10, style: .continuous)).shadow(radius: 10)
                    VStack {
                        CustomTextFieldPriv.CustomTextField(text: $textName, placeHolder: "Öğrenci numarasını giriniz")
                        Button(action: {
                            serviceSend.addStudent(name: "/\(textName)", image: student) { result in
                                switch result {
                                case .success:
                                    print("Öğrenci başarıyla eklendi")
                                case .failure(let error):
                                    print("Hata: \(error.localizedDescription)")
                                }
                            }
                        }, label: {
                            Text("Ekle")
                                .font(.title3)
                                .padding()
                                .frame(width: 250, height: 35)
                                .background(Color(uiColor: UIColor(hex: "4D869C")))
                                .foregroundColor(Color.black)
                                .cornerRadius(4)
                            
                        }).shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 2)
                    }
                    
                }.padding(10)
                
                
                VStack{
                    List(getData.datas) { person in
                        AddedStudent(name: "\(person.no)", photoURL: "\(Config.getPerson)\(person.imageURL)")
                    }
                }
                
            }.sheet(isPresented: $showCameraPicker) {
                // Kamera picker'ını gösterin
                ImagePicker(selectedImage: $student)
            }
            .navigationTitle("Öğrenci Ekle")
            .onAppear {
                            getData.fetchData()
                        }
                        .alert(isPresented: .constant(getData.errorMessage != nil)) {
                            Alert(
                                title: Text("Error"),
                                message: Text(getData.errorMessage ?? "Unknown error"),
                                dismissButton: .default(Text("OK"))
                            )
                        }
        }
    }
}

#Preview {
    StudentAdd(textName: "")
}

/*
 AddedStudent(name: "yusuf", photoURL: "af52277e-a1ff-4d00-92e0-7f3a35706ec63BB57CFC-6E5A-4248-B408-67F622EA518B.jpg")
 AddedStudent(name: "ali", photoURL: "099504a4-3c51-4356-b595-bb2c3e8028abA06A19F2-4292-4DFD-BBE2-EE0A6911CD1D.jpg")
 */

