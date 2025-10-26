//
//  TutorialScreen.swift
//  FoodsPin
//
//  Created by Linas on 26/10/2025.
//

import SwiftUI

struct TutorialScreen: View {
  
  @Environment(\.dismiss) var dismiss
  
  @AppStorage("hasViewedTutorialScreen") var hasViewedTutorialScreen: Bool = false
  
  @State private var currentPage: Int = 0
  
  let pageHeadings = ["CREATE YOUR OWN FOOD GUIDE", "SHOW YOU THE LOCATION", "DISCOVER GREAT RESTAURANTS"]
  let pageSubHeadings = ["Pin your favorite restaurants and create your own food guide", "Search and locate your favorite restaurant on Maps", "Find restaurants shared by your friends and other foodies"]
  let pageImages = [ "onboarding-1", "onboarding-2", "onboarding-3" ]
  
  init() {
    UIPageControl.appearance().currentPageIndicatorTintColor = .systemIndigo
  }
  
  var body: some View {
    VStack {
      TabView(selection: $currentPage) {
        ForEach(pageHeadings.indices, id: \.self) { index in
          TutorialPage(image: pageImages[index], heading: pageHeadings[index], subHeading: pageSubHeadings[index])
            .tag(index)  //The .tag modifier gives each page an unique index
        }
      }
      .tabViewStyle(.page(indexDisplayMode: .always))
      .indexViewStyle(.page(backgroundDisplayMode: .always))
      .animation(.default, value: currentPage)
      
      VStack {
        Button {
          if currentPage < pageHeadings.count - 1 {
            currentPage += 1
          } else {
            hasViewedTutorialScreen = true //not working
            dismiss()
          }
        } label: {
          Text(currentPage == pageHeadings.count - 1 ? "Get Started" : "Next")
            .font(.system(.headline, design: .rounded))
            .foregroundStyle(Color.white)
            .padding()
            .padding(.horizontal, 50)
            .background(Color(.systemIndigo))
            .clipShape(RoundedRectangle(cornerRadius: 25))
        }
        
        if currentPage < pageSubHeadings.count - 1 {
          Button {
            hasViewedTutorialScreen = true
            dismiss()
          } label: {
            Text("Skip")
              .font(.system(.headline, design: .rounded))
              .foregroundStyle(Color.secondary)
          }
        }
      }
      .padding(.bottom)
    }
  }
}

#Preview {
  TutorialScreen()
}
