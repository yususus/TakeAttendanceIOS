//
//  AddedStudent.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 5.05.2024.
//

import SwiftUI

struct AddedStudent: View {
    var name: String
    @StateObject var sendDatabase = SendDatabase()
    
    
    var body: some View {
        VStack{
            HStack {
                if let photoPath = sendDatabase.photoPath {
                                // `photoPath`'i URL'ye dönüştürün
                                if let photoURL = URL(string: photoPath) {
                                    // Fotoğrafı `AsyncImage` ile gösterin
                                    AsyncImage(url: photoURL) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 100, height: 90) // Görüntüleme boyutunu ayarlayabilirsiniz
                                    
                                }
                            } else {
                                Text("Henüz yüklenmedi").frame(width: 100)
                            }
                Text(name).frame(width: 150,height: 75).fontDesign(.serif).font(.title3)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "trash.fill").foregroundStyle(Color.red).font(.title2)
                    
                })
            }.padding(.horizontal, 40)
            
            
        }.frame(width: 350, height: 100)
            .background(Color.gray.opacity(0.4))
            .clipShape(.rect(cornerRadius: 10))
        
    }
}

#Preview {
    AddedStudent(name: "Yusuf aydın")
}
