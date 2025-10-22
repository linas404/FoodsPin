//
//  RestaurantDetailScreen.swift
//  FoodsPin
//
//  Created by linasdev on 22/10/2025.
//

import SwiftUI

struct RestaurantDetailScreen: View {
  
  let restaurant: RestaurantModel
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        Image(restaurant.image)
          .resizable()
          .scaledToFill()
          .frame(minWidth: 0, maxWidth: .infinity)
          .frame(height: 445)
          .overlay {
            VStack {
              Image(systemName: restaurant.isFavorite ? "heart.fill" : "heart")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
                .padding()
                .font(.system(size: 30))
                .foregroundStyle(Color.primary)
                .padding(.top, 40)
              
              VStack(alignment: .leading, spacing: 5) {
                Text(restaurant.name)
                  .font(.custom("Nunito-Regular", size: 35, relativeTo: .largeTitle))
                  .bold()
                
                Text(restaurant.type)
                  .font(.system(.headline, design: .rounded))
                  .padding(5)
                  .background(Color.black)
              }
              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
              .foregroundStyle(Color.white)
              .padding()
            }
          }
      }
      
      Text(restaurant.description)
        .padding()
      
      HStack(alignment: .top) {
        VStack(alignment: .leading) {
          Text("ADDRESS")
            .font(.system(.headline, design: .rounded))
          
          Text(restaurant.location)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        
        VStack(alignment: .leading) {
          Text("PHONE")
            .font(.system(.headline, design: .rounded))
          
          Text(restaurant.phone)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      }
      .padding(.horizontal)
      
      NavigationLink {
        MapView(location: restaurant.location)
      } label: {
        MapView(location: restaurant.location)
          .frame(height: 200)
          .clipShape(RoundedRectangle(cornerRadius: 20))
          .padding()
      }

    }
    .ignoresSafeArea()
  }
}

#Preview {
  RestaurantDetailScreen(restaurant: RestaurantModel(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "cafedeadend", isFavorite: true))
}
