//
//  NewRestaurantScreen.swift
//  FoodsPin
//
//  Created by Linas on 25/10/2025.
//

import SwiftUI

struct NewRestaurantScreen: View {
  
  @Environment(\.dismiss) private var dismiss
  
  //The reason why we store the image as an UIImage object is that the image returned from the photo library also has a type of UIImage
  @State private var restaurantImage: UIImage = UIImage(named: "newphoto")!
  @State private var photoSource: PhotoSource?
  @State private var showPhotoOptions: Bool = false
  @State private var showImagePicker: Bool = false
  @State private var showCamera: Bool = false
  
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack {
          Image(uiImage: restaurantImage)
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 200)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 20.0))
            .padding(.bottom)
            .onTapGesture {
              showPhotoOptions.toggle()
            }
          
          FormTextField(value: .constant(""), label: "NAME", placeholder: "Fill in the restaurant name")
          
          FormTextField(value: .constant(""), label: "TYPE", placeholder: "Fill in the restaurant type")
          
          FormTextField(value: .constant(""), label: "ADDRESS", placeholder: "Fill in the restaurant address")
          
          FormTextField(value: .constant(""), label: "PHONE", placeholder: "Fill in the restaurant phone")
          
          FormTextView(value: .constant(""), label: "DESCRIPTION", height: 100)
        }
        .padding()
      }
      .navigationTitle("New Restaurant")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button {
            dismiss()
          } label: {
            Image(systemName: "xmark")
          }
        }
        
        ToolbarItem(placement: .confirmationAction) {
          Button {
            
          } label: {
            Image(systemName: "checkmark")
          }
        }
      }
      .confirmationDialog("Choose your photo source", isPresented: $showPhotoOptions, titleVisibility: .visible) {
        Button("Camera") {
          showCamera = true
        }
        
        Button("Photo Library") {
          showImagePicker = true
        }
      }
      .sheet(isPresented: $showImagePicker) {
        ImagePicker(selectedImage: $restaurantImage)
      }
      .sheet(isPresented: $showCamera) {
        CameraPicker(selectedImage: $restaurantImage)
      }
    }
  }
}



#Preview {
  NavigationStack {
    NewRestaurantScreen()
  }
}
