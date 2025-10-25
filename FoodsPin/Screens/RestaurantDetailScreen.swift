//
//  RestaurantDetailScreen.swift
//  FoodsPin
//
//  Created by linasdev on 22/10/2025.
//

import SwiftUI

struct RestaurantDetailScreen: View {
  
  @State private var isPresentedReviewView: Bool = false
  
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
              
              HStack(alignment: .bottom) {
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
                
                if let rating = restaurant.rating, !isPresentedReviewView {
                  Image(rating.image)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding([.bottom, .trailing])
                    .transition(.scale)
                }
              }
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
      
      Button {
        isPresentedReviewView.toggle()
      } label: {
        Text("Rate it")
          .font(.system(.headline, design: .rounded))
          .frame(minWidth: 0, maxWidth: .infinity)
      }
      .tint(Color.accent)
      .buttonStyle(.borderedProminent)
      .buttonBorderShape(.roundedRectangle(radius: 25))
      .controlSize(.large)
      .padding(.horizontal)
      .padding(.bottom, 20)
      
    }
    .ignoresSafeArea()
    .overlay {
      isPresentedReviewView ? ZStack { ReviewView(isDisplayed: $isPresentedReviewView, restaurant: restaurant) } : nil
    }
  }
}

#Preview {
  RestaurantDetailScreen(restaurant: RestaurantModel.restaurantData)
}
