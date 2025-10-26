//
//  AboutScreen.swift
//  FoodsPin
//
//  Created by Linas on 26/10/2025.
//

import SwiftUI

enum WebLink: String, Identifiable {
  case rateUs = "https://www.linasdev.io"
  case feedback = "https://www.apple.no"
  case twitter = "https://www.x.com"
  case facebook = "https://www.facebook.com"
  case instagram = "https://www.instagram.com"
  
  var id: UUID {
    return UUID()
  }
}

struct AboutScreen: View {
  
  @State private var link: WebLink?
  
  var body: some View {
    NavigationStack {
      List {
        Image("about")
          .resizable()
          .scaledToFit()
        
        Section {
          Link(destination: URL(string: WebLink.rateUs.rawValue)!) {
            Label("Rate us on App Store", image: "store")
          }
          
          Label("Tell us your feedback", image: "chat")
            .onTapGesture {
              link = .feedback
            }
        }
        .tint(Color.primary)
        
        Section {
          Label("Twitter", image: "twitter")
            .onTapGesture {
              link = .twitter
            }
          
          Label("Facebook", image: "facebook")
            .onTapGesture {
              link = .facebook
            }
          
          Label("Instagram", image: "instagram")
            .onTapGesture {
              link = .instagram
            }
        }
      }
      .listStyle(.grouped)
      .navigationTitle("About")
      .navigationBarTitleDisplayMode(.automatic)
      .sheet(item: $link) { item in
        if let url = URL(string: item.rawValue) {
          //WebView(url: url)
          SafariView(url: url)
        }
      }
    }
  }
}

#Preview {
  AboutScreen()
}
