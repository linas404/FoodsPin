//
//  RestaurantModel.swift
//  FoodsPin
//
//  Created by linasdev on 22/10/2025.
//

import Foundation
import Combine

//When a property is marked with @Published, it signifies that the publisher (in this case, the Restaurant class) should notify all subscribers (i.e., views) whenever the value of that property changes.
class RestaurantModel: ObservableObject, Identifiable {
  @Published var id: String = UUID().uuidString
  @Published var name: String
  @Published var type: String
  @Published var location: String
  @Published var phone: String
  @Published var description: String
  @Published var image: String
  @Published var isFavorite: Bool
  @Published var rating: Rating?
  
  init(name: String, type: String, location: String, phone: String, description: String, image: String, isFavorite: Bool = false, rating: Rating? = nil ) {
    self.name = name
    self.type = type
    self.location = location
    self.phone = phone
    self.description = description
    self.image = image
    self.isFavorite = isFavorite
    self.rating = rating
  }
}

extension RestaurantModel {
  static var restaurantData: RestaurantModel = RestaurantModel(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "cafedeadend", isFavorite: false, rating: .good)
}



