//
//  UIImagePickerController.swift
//  FoodsPin
//
//  Created by Linas on 25/10/2025.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
  
  @Binding var selectedImage: UIImage
  @Environment(\.dismiss) private var dismiss
  
  func makeUIViewController(context: Context) -> PHPickerViewController {
    var configuration = PHPickerConfiguration()
    configuration.filter = .images
    configuration.selectionLimit = 1
    
    let picker = PHPickerViewController(configuration: configuration)
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  final class Coordinator: NSObject, PHPickerViewControllerDelegate {
    var parent: ImagePicker
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      parent.dismiss()
      
      guard let result = results.first else { return }
      
      result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
        if let image = image as? UIImage {
          DispatchQueue.main.async {
            self?.parent.selectedImage = image
          }
        }
      }
    }
  }
}
