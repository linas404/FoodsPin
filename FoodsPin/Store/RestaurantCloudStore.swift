//
//  RestaurantCloudStore.swift
//  FoodsPin
//
//  Created by Linas on 26/10/2025.
//

import SwiftUI
import CloudKit

@Observable
class RestaurantCloudStore {
  
  var restaurants: [CKRecord] = []
  
  func fetchRestaurants() async throws {
    // Išvalom senus duomenis prieš užkraunant naujus
    self.restaurants.removeAll()
    
    //Fetch data using Convenience API
    let cloudContainer = CKContainer.default()
    let publicDatabase = cloudContainer.publicCloudDatabase
    let predicate = NSPredicate(value: true)
    let query = CKQuery(recordType: "Restaurant", predicate: predicate)
    
    let resuts = try await publicDatabase.records(matching: query)
    
    for record in resuts.matchResults {
      self.restaurants.append(try record.1.get())
    }
  }
  
  func fetchRestaurantsWithOperational(completion: @escaping () -> ()) {
    
    self.restaurants.removeAll()
    
    let cloudContainer = CKContainer.default()
    let publicDatabase = cloudContainer.publicCloudDatabase
    let predicate = NSPredicate(value: true)
    let query = CKQuery(recordType: "Restaurant", predicate: predicate)
    query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    
    //Create the query operation with the query
    let queryOperation = CKQueryOperation(query: query)
    queryOperation.desiredKeys = ["name", "image"] //desiredKeys savybė leidžia nurodyti, kuriuos laukus norite gauti.
    queryOperation.queuePriority = .veryHigh //queuePriority savybę – ji leidžia nustatyti operacijos vykdymo prioritetą.
    queryOperation.resultsLimit = 50 // resultsLimit savybę – ji leidžia nustatyti maksimalų vienu metu gaunamų įrašų skaičių.
    
    //recordMatchedBlock – šis kodo blokas vykdomas kiekvieną kartą, kai gaunamas naujas įrašas. Pavyzdyje kiekvieną gautą įrašą pridedame į restaurants masyvą.
    queryOperation.recordMatchedBlock = { (recordID, result) -> Void in
      if let restaurant = try? result.get() {
        DispatchQueue.main.async {
          self.restaurants.append(restaurant)
        }
      }
    }
    
    //Kalbant plačiau apie queryResultBlock, jis pateikia kursorių (per rezultatų objektą), kuris nurodo, ar dar yra likusių rezultatų. Kadangi naudojame resultsLimit norėdami apriboti vienu metu gaunamų įrašų skaičių, aplikacija gali negauti visų duomenų vienos užklausos metu.
    //Tokiu atveju CKQueryCursor objektas nurodo, kad yra daugiau rezultatų. Jis pažymi užklausos pabaigos tašką ir pradžios tašką, nuo kurio reikia tęsti gavimą.
    //Kursorius yra labai naudingas, jei norite gauti didelius duomenų kiekius keliais etapais. Tai vienas iš būdų efektyviai atsisiųsti didelį įrašų rinkinį.
    queryOperation.queryResultBlock = { result -> Void in
      switch result {
        case .success(_):
          print("Successfully retrieve the data from iCloud.")
        case .failure(let error):
          print("Failed to get data from iCloud - \(error.localizedDescription)")
      }
      
      //When the records are retrieved, we call the completion() function to execute whatever operation specified by the caller
      DispatchQueue.main.async {
        completion()
      }
    }
    
    publicDatabase.add(queryOperation)
  }
  
  func saveRecordToCloud(restaurant: RestaurantModel) {
    let record = CKRecord(recordType: "Restaurant")
    record.setValue(restaurant.name, forKey: "name")
    record.setValue(restaurant.type, forKey: "type")
    record.setValue(restaurant.location, forKey: "location")
    record.setValue(restaurant.phone, forKey: "phone")
    record.setValue(restaurant.descript, forKey: "description")
    
    //resize image
    //we don't want to upload a super-high resolution photo. We would like to scale it down before uploading.
    let originalImage = restaurant.image
    //any photo with a width larger than 1024 pixels will be resized
    let scalingFactor = (originalImage.size.width > 1024) ? 1024 / originalImage.size.width : 1.0
    
    guard let imageData = originalImage.pngData() else {
      return
    }
    
    let scaledImage = UIImage(data: imageData, scale: scalingFactor)
    
    // Write the image to local file for temporary use
    let imageFilePath = NSTemporaryDirectory() + restaurant.name
    let imageFileURL = URL(fileURLWithPath: imageFilePath)
    try? scaledImage?.jpegData(compressionQuality: 0.8)?.write(to: imageFileURL)
    
    // Create image asset for upload
    let imageAsset = CKAsset(fileURL: imageFileURL)
    record.setValue(imageAsset, forKey: "image")
    
    // Get the Public iCloud Database
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    publicDatabase.save(record) { (record, error) -> Void in
      if error != nil {
        print(error?.localizedDescription ?? "")
      }
      
      try? FileManager.default.removeItem(at: imageFileURL)
    }
  }
}
