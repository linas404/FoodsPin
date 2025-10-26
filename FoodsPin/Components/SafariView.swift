//
//  SafariView.swift
//  FoodsPin
//
//  Created by Linas on 26/10/2025.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
  
  var url: URL
  
  func makeUIViewController(context: Context) -> SFSafariViewController {
    return SFSafariViewController(url: url)
  }
  
  func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    
  }
}
