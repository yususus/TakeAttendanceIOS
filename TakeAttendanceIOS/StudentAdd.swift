//
//  StudentAdd.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 5.05.2024.
//

import SwiftUI

struct StudentAdd: View {
    @State private var showCameraPicker = false
    @State private var capturedImage: UIImage? = nil
    @State var textName: String
    var body: some View {
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
                
                StudentAdd.CustomTextField(text: $textName, placeHolder: "Öğrenci adını giriniz")
            }.padding(10)
                
            
            Button(action: {
                           // action()
                        }, label: {
                            Text("Ekle")
                                .font(.title3)
                                .padding()
                                .frame(width: 75, height: 35)
                                .background(Color.gray)
                                .foregroundColor(Color.white)
                                .cornerRadius(4)
                            
                        }).shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 2)
            Spacer()
            
            VStack{
                ScrollView{
                    
                }
            }.padding()
        }.sheet(isPresented: $showCameraPicker) {
            // Kamera picker'ını gösterin
            ImagePicker(selectedImage: $capturedImage)
        }
    }
    
    
    @ViewBuilder
    static func CustomTextField(text: Binding<String>, placeHolder: String) -> some View{
        VStack{
            ZStack(alignment: .leading) {
                if text.wrappedValue.isEmpty {
                    Text(placeHolder)
                        .foregroundColor(.black.opacity(0.6)).padding()
                }
                TextField("", text: text)
                    .foregroundColor(.black).padding()
            }
            
        }.frame(width: 250, height: 50)
            .background(Color.yellow.opacity(0.3))
            .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    StudentAdd(textName: "")
}
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Güncelleme işlemleri (gerekirse) burada yapılabilir
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            // Kullanıcı fotoğraf çektiğinde çağrılır
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            // Picker'ı kapat
            picker.dismiss(animated: true, completion: nil)
        }
    }
}