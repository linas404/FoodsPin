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
  }
}

#Preview {
  HomeScreen()
    .modelContainer(RestaurantModel.preview)
}
