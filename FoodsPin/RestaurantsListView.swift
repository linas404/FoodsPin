//
//  RestaurantsListView.swift
//  FoodsPin
//
//  Created by linasdev on 21/10/2025.
//

import SwiftUI

struct RestaurantsListView: View {
  
  var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
  
  var restaurantImages = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
  
  var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
  
  var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
  
  var body: some View {
    List {
      ForEach(restaurantNames.indices, id: \.self) { index in
        RestaurantRow(
          imageName: restaurantImages[index],
          name: restaurantNames[index],
          type: restaurantTypes[index],
          location: restaurantLocations[index]
        )
      }
      .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
  }
}

struct RestaurantRow: View {
  
  @State private var isPresentedOptions: Bool = false
  @State private var isShowError: Bool = false
  
  var imageName: String
  var name: String
  var type: String
  var location: String
  
  var body: some View {
    HStack(alignment: .top, spacing: 20) {
      Image(imageName)
        .resizable()
        .scaledToFit()
        .frame(width: 120, height: 118)
        .clipShape(RoundedRectangle(cornerRadius: 20))
      
      VStack(alignment: .leading) {
        Text(name)
          .font(.system(.title2, design: .rounded))
        
        Text(type)
          .font(.system(.body, design: .rounded))
        
        Text(location)
          .font(.system(.subheadline, design: .rounded))
          .foregroundStyle(.secondary)
      }
    }
    .onTapGesture {
      isPresentedOptions.toggle()
    }
    .confirmationDialog("What do you want to do?", isPresented: $isPresentedOptions, titleVisibility: .visible) {
      Button("Reserve a table") {
        isShowError.toggle()
      }
      
      Button("Mark as favorite") {
        
      }
    }
    .alert("Not yet available", isPresented: $isShowError) {
      Button("OK") {
        
      }
    } message: {
      Text("Sorry, this feature is not available yet. Please retry later.")
    }
  }
}

#Preview {
  RestaurantsListView()
}
