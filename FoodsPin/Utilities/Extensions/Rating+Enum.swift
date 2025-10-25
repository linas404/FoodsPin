//
//  Rating+Enum.swift
//  FoodsPin
//
//  Created by Linas on 25/10/2025.
//

import Foundation

//The String type indicates that strings are used for raw values
enum Rating: String, CaseIterable, Identifiable {
  case awesome, good, okay, bad, terrible
  
  var id: Self {
    return self
  }
  
  var image: String {
    switch self {
      case .awesome:
        return "love"
      case .good:
        return "cool"
      case .okay:
        return "happy"
      case .bad:
        return "sad"
      case .terrible:
        return "angry"
    }
  }
}
