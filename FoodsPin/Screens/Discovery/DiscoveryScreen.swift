//
//  DiscoveryScreen.swift
//  FoodsPin
//
//  Created by Linas on 26/10/2025.
//

import SwiftUI
import CloudKit

struct DiscoveryScreen: View {
  
  @State private var cloudStore: RestaurantCloudStore = RestaurantCloudStore()
  @State private var isShowLoadingIndicator: Bool = false
  
  var body: some View {
    NavigationStack {
      ZStack {
        List {
          ForEach(cloudStore.restaurants, id: \.recordID) { restaurant in
            HStack {
              AsyncImage(url: getImageURL(restaurant: restaurant)) { image in
                image
                  .resizable()
                  .scaledToFill()
              } placeholder: {
                Color.purple.opacity(0.1)
              }
              .frame(width: 50, height: 50)
              .clipShape(RoundedRectangle(cornerRadius: 10))
              
              Text(restaurant.object(forKey: "name") as! String)
            }
          }
        }
        
        if isShowLoadingIndicator {
          ProgressView()
        }
      }
      .listStyle(.plain)
      .navigationTitle("Discover")
      .navigationBarTitleDisplayMode(.automatic)
      .task {
        //        do {
        //          try await cloudStore.fetchRestaurants()
        //        } catch {
        //          print(error)
        //        }
        cloudStore.fetchRestaurantsWithOperational(completion: {
          isShowLoadingIndicator = false
        })
      }
      .onAppear(perform: {
        isShowLoadingIndicator = true
      })
    }
  }
  
  private func getImageURL(restaurant: CKRecord) -> URL? {
    guard let image = restaurant.object(forKey: "image"),
          let imageAsset = image as? CKAsset else {
      return nil
    }
    
    return imageAsset.fileURL
  }
}

#Preview {
  DiscoveryScreen()
}
