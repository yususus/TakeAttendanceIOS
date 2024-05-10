//
//  ImagePicker.swift
//  TakeAttendanceIOS
//
//  Created by yusuf on 9.05.2024.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
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
