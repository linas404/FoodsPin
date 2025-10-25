//
//  PhotoSource+Enum.swift
//  FoodsPin
//
//  Created by Linas on 25/10/2025.
//

import Foundation

enum PhotoSource: Identifiable {
  case photoLibraty, camera
  
  var id: Int {
    hashValue
  }
}
