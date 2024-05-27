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
    @StateObject var getScan = GetScanPhoto()
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack {
                    Button(action: {
                        showCamera = true
                    }, label: {
                        HStack {
                            Text("Taramaya Başla")
                                .fontWeight(.bold)
                                .frame(width: 140, height: 45)
                                .foregroundColor(Color.white)
                            Image(systemName: "person.crop.square.badge.camera")
                                .resizable().aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                                .foregroundStyle(Color.white)
                        }
                        
                    }).frame(width: 350, height: 75)
                        .background(Color(uiColor: UIColor(hex: "7AB2B2"))).clipShape(.rect(cornerRadius: 10, style: .continuous)).shadow(radius: 10)
                   // Divider().frame(height: 100).frame(minWidth: 0.5).background(Color.black)
                    //Spacer()
                    /*
                    Button(action: {
                        if let image = attendance {
                            getScan.scanStudent(image: image) { result in
                                switch result {
                                case .success():
                                    print("Başarılı")
                                case .failure(let error):
                                    print("Hata: \(error.localizedDescription)")
                                }
                            }
                        }
                    }, label: {
                        Text("Start Scan")
                            .font(.title3)
                            .padding()
                            .frame(width: 140, height: 45)
                            .foregroundColor(Color.white)
                            .background(Color(uiColor: UIColor(hex: "4D869C")))
                            .cornerRadius(4)
                    })
                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 2)*/
                }
                .padding(.horizontal, 40)
                .frame(width: 400)
                
                
                Divider().frame(width: 350).frame(minHeight: 2).background(Color.black)
                
                ScrollView {
                    if getScan.isLoading {
                        ProgressView("Yükleniyor...")
                    } else if let errorMessage = getScan.errorMessage {
                        Text("Hata: \(errorMessage)")
                            .foregroundColor(.red)
                    } else {
                        ForEach(getScan.students, id: \.id){
                            student in
                            AddedStudent(name: "\(student.no)", photoURL: "\(Config.getPerson)\(student.imageUrl)")
                        }
                        /*
                        ForEach(getScan.students, id: \.id) { student in
                            VStack(alignment: .leading) {
                                Text("Numara: \(student.no)")
                                Text("Görsel URL: \(student.imageUrl)")
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                        }
                        */
                    }
                }
            }
            .sheet(isPresented: $showCamera) {
                ImagePicker(selectedImage: $attendance)
            }.onChange(of: attendance) { _ in
                // Resim seçildikten sonra tarama işlemini başlat
                if let image = attendance {
                    getScan.scanStudent(image: image) { result in
                        switch result {
                        case .success():
                            print("Başarılı")
                        case .failure(let error):
                            print("Hata: \(error.localizedDescription)")
                        }
                    }
                }
            }
            .navigationTitle("Yoklama Al")
        }
        
    }
}

#Preview {
    StudentTaken()
}
