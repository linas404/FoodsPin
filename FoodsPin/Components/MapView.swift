//
//  MapView.swift
//  FoodsPin
//
//  Created by linasdev on 22/10/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
  
  var location: String = ""
  
  @State private var position: MapCameraPosition = .automatic
  @State private var markerLocation = CLLocation()
  
  var body: some View {
    Map(position: $position) {
      Marker("Here", coordinate: markerLocation.coordinate)
        .tint(.red)
    }
      .task {
        await convertAddress(location: location)
      }
  }
  
  private func convertAddress(location: String) async {
    let trimmed = location.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else { return }
    
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = trimmed
    
    let search = MKLocalSearch(request: request)
    do {
      let response = try await search.start()
      if let item = response.mapItems.first {
        let coordinate = item.location.coordinate
        let region = MKCoordinateRegion(
          center: coordinate,
          span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015)
        )
        await MainActor.run {
          position = .region(region)
          markerLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
      }
    } catch {
      print("Geocoding (MapKit search) failed:", error.localizedDescription)
    }
  }
}

#Preview {
  MapView(location: "Melioratorių aikštė 1, Joniskis, Lithuania")
}


