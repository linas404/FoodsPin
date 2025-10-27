//
//  FoodsPinApp.swift
//  FoodsPin
//
//  Created by linasdev on 21/10/2025.
//

import SwiftUI
import SwiftData

@main
struct FoodsPinApp: App {
  
  @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
  
  @Environment(\.scenePhase) var scenePhase
  
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
      HomeScreen()
    }
    .modelContainer(for: [RestaurantModel.self])
    .onChange(of: scenePhase) { oldValue, newValue in
      switch newValue {
        case .background:
          createQuickActions()
        case .inactive:
          print("Inactive")
        case .active:
          print("Active")
        @unknown default:
          print("Default scene phase")
      }
    }
  }
  
  func createQuickActions() {
    if let bundleIdentifier = Bundle.main.bundleIdentifier {
      let shortcutItem1 = UIApplicationShortcutItem(type: "\(bundleIdentifier).OpenFavorites", localizedTitle: "Show Favorites", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(systemImageName: "tag"), userInfo: nil)
      let shortcutItem2 = UIApplicationShortcutItem(type: "\(bundleIdentifier).OpenDiscover", localizedTitle: "Discover Restaurants", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(systemImageName: "eyes"), userInfo: nil)
      let shortcutItem3 = UIApplicationShortcutItem(type: "\(bundleIdentifier).NewRestaurant", localizedTitle: "New Restaurant", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .add), userInfo: nil)
      UIApplication.shared.shortcutItems = [shortcutItem1, shortcutItem2, shortcutItem3]
    }
  }
}

final class MainSceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
    completionHandler(handleQuickAction(shortcutItem: shortcutItem))
  }
  
  private func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
    let shortcutType = shortcutItem.type
    
    guard let shortcutIdentifier = shortcutType.components(separatedBy: ".").last else {
      return false
    }
    
    guard let url = URL(string: "foodpinapp://actions/" + shortcutIdentifier) else {
      print("Failed to initiate the url")
      return false
    }
    
    // Naudokite UIApplication.shared.open vietoj @Environment openURL
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
    
    return true
  }
}

final class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    let configuration = UISceneConfiguration(name: "Main Scene", sessionRole: connectingSceneSession.role)
    
    configuration.delegateClass = MainSceneDelegate.self
    
    return configuration
  }
}
