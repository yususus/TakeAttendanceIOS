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

    @StateObject var sendData = SendData()
    @StateObject var serviceAdd = SendDatabase(apiURL: URL(string: "http://3.75.250.153:8000/uploadfile/1/")!)
    
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
                // "Ekle" düğmesine basıldığında yapılacak işlemler
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
            ImagePicker(selectedImage: $capturedImage)
        }
    }
    
    
    // Öğrenci verilerini sunucuya gönderme işlemi
        func addStudentData() {
            // Öğrenci adını ve çekilen resmi sunucuya gönder
            serviceAdd.addStudent(name: textName, image: capturedImage) { result in
                switch result {
                case .success:
                    // Başarılı olduğunda yapılacak işlemler (örneğin, başarı mesajı göstermek veya UI'yi güncellemek)
                    print("Öğrenci başarıyla eklendi")
                case .failure(let error):
                    // Hata durumunda yapılacak işlemler (örneğin, hata mesajı göstermek)
                    print("Hata: \(error.localizedDescription)")
                }
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
            .background(Color.green.opacity(0.3))
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
