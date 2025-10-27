//
//  NewRestaurantScreen.swift
//  FoodsPin
//
//  Created by Linas on 25/10/2025.
//

import SwiftUI
import SwiftData

struct NewRestaurantScreen: View {
  
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var modelContext
  
  @Bindable private var restaurantFormVM: RestaurantFormViewModel
  
  @State private var showPhotoOptions: Bool = false
  @State private var showImagePicker: Bool = false
  @State private var showCamera: Bool = false
  
  init() {
    let viewModel = RestaurantFormViewModel()
    viewModel.image = UIImage(named: "newphoto") ?? UIImage()
    restaurantFormVM = viewModel
  }
  
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack {
          Image(uiImage: restaurantFormVM.image)
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
          
          FormTextField(value: $restaurantFormVM.name, label: "NAME", placeholder: "Fill in the restaurant name")
          
          FormTextField(value: $restaurantFormVM.type, label: "TYPE", placeholder: "Fill in the restaurant type")
          
          FormTextField(value: $restaurantFormVM.location, label: "ADDRESS", placeholder: "Fill in the restaurant address")
          
          FormTextField(value: $restaurantFormVM.phone, label: "PHONE", placeholder: "Fill in the restaurant phone")
          
          FormTextView(value: $restaurantFormVM.descript, label: "DESCRIPTION", height: 100)
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
            save()
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
        ImagePicker(selectedImage: $restaurantFormVM.image)
      }
      .sheet(isPresented: $showCamera) {
        CameraPicker(selectedImage: $restaurantFormVM.image)
      }
    }
  }
  
  private func save() {
    let newRestaurant = RestaurantModel(name: restaurantFormVM.name, type: restaurantFormVM.type, location: restaurantFormVM.type, phone: restaurantFormVM.phone, descript: restaurantFormVM.descript, image: restaurantFormVM.image)
    modelContext.insert(newRestaurant)
    
    do {
      try modelContext.save()
    } catch {
      fatalError("Can't save this restaurant")
    }
    
    let cloudStore = RestaurantCloudStore()
    cloudStore.saveRecordToCloud(restaurant: newRestaurant)
    
    dismiss()
  }
}



#Preview {
  NavigationStack {
    NewRestaurantScreen()
  }
}
