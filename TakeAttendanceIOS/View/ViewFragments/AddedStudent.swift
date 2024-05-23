//
//  AddedStudent.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 5.05.2024.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
struct AddedStudent: View {
    let name: String
    let photoURL: String
    
    @StateObject var sendDatabase = SendDatabase()
    
    
    var body: some View {
        
            HStack {
                Text(name).frame(width: 150,height: 100).fontDesign(.serif).font(.title3)
                
                WebImage(url: URL(string: Config.addPathToApiUrl2(path: photoURL))) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 100)
                    case .failure(_):
                        Text("Fotoğraf yüklenemedi")
                    case .empty:
                        ProgressView()
                    @unknown default:
                        EmptyView()
                    }
                }
            }.frame(width: 350, height: 100)
            .background(Color(uiColor: UIColor(hex: "40A578")).opacity(0.5))
                .clipShape(.rect(cornerRadius: 10))
        
        
    }
}

#Preview {
    AddedStudent(name: "Yusuf aydın", photoURL: "07068c04-b8f9-48b6-90e9-d5b6dc64ecc1IMG_1387.jpg")
}
