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
        
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                Text(name).frame(width: 150,height: 100).fontDesign(.serif).font(.title3)
            }
            Spacer()
            if let imageURL = URL(string: photoURL) {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 80)
                            .clipShape(Circle())
                    case .failure(_):
                        Text("Fotoğraf yüklenemedi")
                    case .empty:
                        ProgressView()
                        
                    }
                }
            }
        }.padding()
        .frame(width: 350, height: 100)
            .background(Color(uiColor: UIColor(hex: "40A578")).opacity(0.5))
            .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    AddedStudent(name: "Yusuf aydın", photoURL: "http://35.193.152.202:8000/static/07068c04-b8f9-48b6-90e9-d5b6dc64ecc1IMG_1387.jpg")
}
