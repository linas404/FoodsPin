//
//  RestaurantsListView.swift
//  FoodsPin
//
//  Created by linasdev on 21/10/2025.
//

import SwiftUI

struct RestaurantsListView: View {
  
  @State var restaurants = [
    RestaurantModel(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isFavorite: false),
    RestaurantModel(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isFavorite: false),
    RestaurantModel(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
    RestaurantModel(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),
    RestaurantModel(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isFavorite: false),
    RestaurantModel(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkee", isFavorite: false),
    RestaurantModel(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isFavorite: false),
    RestaurantModel(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isFavorite: false),
    RestaurantModel(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haigh", isFavorite: false),
    RestaurantModel(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavorite: false),
    RestaurantModel(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false),
    RestaurantModel(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false),
    RestaurantModel(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavorite: false),
    RestaurantModel(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "waffleandwolf", isFavorite: false),
    RestaurantModel(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavorite: false),
    RestaurantModel(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavorite: false),
    RestaurantModel(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isFavorite: false),
    RestaurantModel(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
    RestaurantModel(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false),
    RestaurantModel(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
    RestaurantModel(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavorite: false)
  ]
  
  var body: some View {
    List {
      ForEach($restaurants) { $restaurant in
        RestaurantRow(restaurant: $restaurant)
      }
      .onDelete(perform: { indexSet in
        restaurants.remove(atOffsets: indexSet)
      })
      .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
  }
}

struct RestaurantRow: View {
  
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
  RestaurantsListView()
}
