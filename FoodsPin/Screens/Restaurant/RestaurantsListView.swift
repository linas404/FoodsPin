//
//  RestaurantsListView.swift
//  FoodsPin
//
//  Created by linasdev on 21/10/2025.
//

import SwiftUI
import SwiftData

struct RestaurantsListView: View {
  
  //This @Query property automatically fetches the required data for you. In the provided code, we specify to fetch the Restaurant objects.
  @Query private var restaurants: [RestaurantModel]
  
  @Environment(\.modelContext) private var modelContext
  
  @AppStorage("hasViewedTutorialScreen") var hasViewedTutorialScreen: Bool = false

  @State private var isPresentedAddRestaurantSheet: Bool = false
  @State private var isPresentedTutorialView: Bool = false
  
  var body: some View {
    NavigationStack {
      Group {
        if restaurants.isEmpty {
          ContentUnavailableView("Empty Restaurants", systemImage: "fork.knife", description: Text("You need to add restaurants"))

        } else {
          List {
            ForEach(restaurants) { restaurant in
              ZStack(alignment: .leading) {
                NavigationLink {
                  RestaurantDetailScreen(restaurant: restaurant)
                } label: {
                  EmptyView()
                }
                .opacity(0)
                
                RestaurantRowView(restaurant: restaurant)
              }
            }
            .onDelete(perform: deleteRestaurant)
            .listRowSeparator(.hidden)
          }
          .listStyle(.plain)
        }
      }
      .onAppear(perform: {
        //isPresentedTutorialView = hasViewedTutorialScreen ? false : true
      })
      .navigationTitle("Food Pin")
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button {
            isPresentedAddRestaurantSheet.toggle()
          } label: {
            Image(systemName: "plus")
          }

        }
      }
      .sheet(isPresented: $isPresentedAddRestaurantSheet) {
        NewRestaurantScreen()
      }
      .sheet(isPresented: $isPresentedTutorialView) {
        TutorialScreen()
      }
    }
  }
  
  private func deleteRestaurant(indexSet: IndexSet) {
    indexSet.forEach { index in
      let deleteItem = restaurants[index]
      modelContext.delete(deleteItem)
      
      do {
        try modelContext.save()
      } catch {
        print("Error delete restaurant")
      }
    }
  }
}

#Preview {
  RestaurantsListView()
    .modelContainer(RestaurantModel.preview)
}
