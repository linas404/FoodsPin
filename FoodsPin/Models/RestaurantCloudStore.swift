//
//  RestaurantCloudStore.swift
//  FoodsPin
//
//  Created by Linas on 26/10/2025.
//

import SwiftUI
import CloudKit

@Observable
class RestaurantCloudStore {
  
  var restaurants: [CKRecord] = []
  
  func fetchRestaurants() async throws {
    // Išvalom senus duomenis prieš užkraunant naujus
    self.restaurants.removeAll()
    
    //Fetch data using Convenience API
    let cloudContainer = CKContainer.default()
    let publicDatabase = cloudContainer.publicCloudDatabase
    let predicate = NSPredicate(value: true)
    let query = CKQuery(recordType: "Restaurant", predicate: predicate)
    
    let resuts = try await publicDatabase.records(matching: query)
    
    for record in resuts.matchResults {
      self.restaurants.append(try record.1.get())
    }
  }
}
