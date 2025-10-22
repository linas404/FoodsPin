//
//  ActivityView.swift
//  FoodsPin
//
//  Created by linasdev on 22/10/2025.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
  
  var activityItems: [Any]
  var applicationActivities: [UIActivity]? = nil
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
  
  func makeUIViewController(context: Context) -> some UIViewController {
    let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    return activityController
  }
  
}
