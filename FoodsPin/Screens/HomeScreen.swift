//
//  HomeScreen.swift
//  FoodsPin
//
//  Created by Linas on 26/10/2025.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
  
  @State private var selectedTabIndex: Int = 0
  
  var body: some View {
    TabView(selection: $selectedTabIndex) {
      Tab("Favorites", systemImage: "tag.fill", value: 0) {
        RestaurantsListView()
      }
      
      Tab("Discover", systemImage: "wand.and.rays", value: 1) {
        DiscoveryScreen()
      }
      
      Tab("About", systemImage: "square.stack", value: 2) {
        AboutScreen()
      }
    }
    .tint(Color.accent)
    .onOpenURL(perform: { url in
      switch url.path {
        case "/OpenFavorites": selectedTabIndex = 0
        case "/OpenDiscover": selectedTabIndex = 1
        case "/NewRestaurant": selectedTabIndex = 0
        default: return
      }
    })
  }
}

#Preview {
  HomeScreen()
    .modelContainer(RestaurantModel.preview)
}
