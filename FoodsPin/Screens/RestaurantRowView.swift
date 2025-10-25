//
//  RestaurantRowView.swift
//  FoodsPin
//
//  Created by Linas on 25/10/2025.
//

import SwiftUI

struct RestaurantRowView: View {
  
  @Binding var restaurant: RestaurantModel
  
  @State private var isPresentedOptions: Bool = false
  @State private var isShowError: Bool = false
  
  var body: some View {
    HStack(alignment: .top, spacing: 20) {
      Image(restaurant.image)
        .resizable()
        .scaledToFill()
        .frame(width: 120, height: 118)
        .clipShape(RoundedRectangle(cornerRadius: 20))
      
      
      VStack(alignment: .leading) {
        Text(restaurant.name)
          .font(.system(.title2, design: .rounded))
        
        Text(restaurant.type)
          .font(.system(.body, design: .rounded))
        
        Text(restaurant.location)
          .font(.system(.subheadline, design: .rounded))
          .foregroundStyle(.secondary)
      }
      
      Spacer()
      
      Image(systemName: restaurant.isFavorite ? "heart.fill" : "heart")
    }
    .contextMenu {
      Button {
        isShowError.toggle()
      } label: {
        HStack {
          Image(systemName: "phone")
          Text("Reserve a table")
        }
      }
      
      Button {
        restaurant.isFavorite.toggle()
      } label: {
        HStack {
          Image(systemName: "heart")
          Text(restaurant.isFavorite ? "Remove from favorites" : "Mark as favorite")
        }
      }
      
      Button {
        isPresentedOptions.toggle()
      } label: {
        HStack {
          Image(systemName: "square.and.arrow.up")
          Text("Share")
        }
      }
    }
    .alert("Not yet available", isPresented: $isShowError) {
      Button("OK") {
        isShowError.toggle()
      }
    } message: {
      Text("Sorry, this feature is not available yet. Please retry later.")
    }
    .sheet(isPresented: $isPresentedOptions) {
      let defaultText = "Just checking in at \(restaurant.name)"
      if let imageToShare = UIImage(named: restaurant.image) {
        ActivityView(activityItems: [defaultText, imageToShare])
      } else {
        ActivityView(activityItems: [defaultText])
      }
    }
  }
}

#Preview {
  RestaurantRowView(restaurant: .constant(RestaurantModel.restaurantData))
}
