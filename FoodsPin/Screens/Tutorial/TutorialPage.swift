//
//  TutorialPage.swift
//  FoodsPin
//
//  Created by Linas on 26/10/2025.
//

import SwiftUI

struct TutorialPage: View {
  
  let image: String
  let heading: String
  let subHeading: String
  
  var body: some View {
    VStack(spacing: 70) {
      Image(image)
        .resizable()
        .scaledToFit()
      
      VStack(spacing: 10) {
        Text(heading)
          .font(.system(.headline, design: .rounded))
        
        Text(subHeading)
          .font(.system(.body, design: .rounded))
          .foregroundStyle(Color.secondary)
          .multilineTextAlignment(.center)
      }
      .padding(.horizontal)
      
      Spacer()
    }
    .padding(.top)
  }
}

#Preview("TutorialPage") {
  TutorialPage(image: "onboarding-1", heading: "CREATE YOUR OWN FOOD GUIDE", subHeading: "Pin your favorite restaurants and create your own food guide")
}
