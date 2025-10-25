//
//  ReviewView.swift
//  FoodsPin
//
//  Created by Linas on 25/10/2025.
//

import SwiftUI

struct ReviewView: View {
  
  @Binding var isDisplayed: Bool
  
  @State private var showRatings: Bool = false
  
  let restaurant: RestaurantModel
  
  var body: some View {
    ZStack {
      Image(restaurant.image)
        .resizable()
        .scaledToFill()
        .frame(minWidth: 0, maxWidth: .infinity)
        .ignoresSafeArea()
      
      Color.black
        .opacity(0.6)
        .background(.ultraThinMaterial)
        .ignoresSafeArea()
      
      HStack {
        Spacer()
        
        VStack {
          Button {
            withAnimation(.easeOut(duration: 0.3)) {
              isDisplayed = false
            }
          } label: {
            Image(systemName: "xmark")
              .font(.system(size: 30))
              .foregroundStyle(Color.white)
              .padding()
          }
          
          Spacer()
        }
      }
      
      VStack(alignment: .leading) {
        ForEach(Rating.allCases) { rating in
          HStack {
            Image(rating.image)
            Text(rating.rawValue.capitalized)
              .font(.system(.title, design: .rounded, weight: .bold))
              .foregroundStyle(Color.white)
          }
          .opacity(showRatings ? 1.0 : 0)
          .offset(x: showRatings ? 0 : 1000)
          .animation(.easeOut.delay(Double(Rating.allCases.firstIndex(of: rating)!) * 0.05), value: showRatings)
          .onTapGesture {
            restaurant.rating = rating
            isDisplayed = false
          }
        }
      }
    }
    .onAppear {
      showRatings.toggle()
    }
  }
}

#Preview {
  ReviewView(isDisplayed: .constant(true), restaurant: RestaurantModel.restaurantData)
}
