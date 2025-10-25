//
//  RestaurantModel.swift
//  FoodsPin
//
//  Created by linasdev on 22/10/2025.
//

import Foundation

struct RestaurantModel: Identifiable, Hashable {
  var id: String = UUID().uuidString
  var name: String
  var type: String
  var location: String
  var phone: String
  var description: String
  var image: String
  var isFavorite: Bool
  
  init(name: String, type: String, location: String, phone: String, description: String, image: String, isFavorite: Bool = false) {
    self.name = name
    self.type = type
    self.location = location
    self.phone = phone
    self.description = description
    self.image = image
    self.isFavorite = isFavorite
  }
  
  init() {
    self.init(name: "", type: "", location: "", phone: "", description: "", image: "", isFavorite: false)
  }}

extension RestaurantModel {
  static var restaurantData: RestaurantModel = RestaurantModel(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "cafedeadend", isFavorite: false)
}



