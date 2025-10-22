//
//  FoodsPinApp.swift
//  FoodsPin
//
//  Created by linasdev on 21/10/2025.
//

import SwiftUI

@main
struct FoodsPinApp: App {
  
  init() {
    let navBarAppearance = UINavigationBarAppearance()
    navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 218, green: 96, blue: 51), .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
    navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(red: 218, green: 96, blue: 51), .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]
    navBarAppearance.backgroundColor = .clear
    navBarAppearance.backgroundEffect = .none
    navBarAppearance.shadowColor = .clear
    
    UINavigationBar.appearance().standardAppearance = navBarAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    UINavigationBar.appearance().compactAppearance = navBarAppearance
  }
  
  var body: some Scene {
    WindowGroup {
      RestaurantsListView()
    }
  }
}
