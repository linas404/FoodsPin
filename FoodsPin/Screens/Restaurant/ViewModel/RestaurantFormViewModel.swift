//
//  RestaurantFormViewModel.swift
//  FoodsPin
//
//  Created by Linas on 25/10/2025.
//

import SwiftUI

@Observable
class RestaurantFormViewModel {
  var name: String = ""
  var type: String = ""
  var location: String = ""
  var phone: String = ""
  var descript: String = ""
  var image: UIImage = UIImage()
  
  init(restaurant: RestaurantModel? = nil) {
    if let restaurant = restaurant {
      self.name = restaurant.name
      self.type = restaurant.type
      self.location = restaurant.location
      self.phone = restaurant.phone
      self.descript = restaurant.descript
      self.image = restaurant.image
    }
  }
}
