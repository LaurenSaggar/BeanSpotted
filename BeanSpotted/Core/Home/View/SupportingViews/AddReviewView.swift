//
//  AddReviewView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/22/24.

import SwiftUI
import MapKit
import CoreLocation


struct AddReviewView: View {

    @ObservedObject var reviewViewModel: ReviewViewModel
    @ObservedObject var shopViewModel: CoffeeShopViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var errorMessage = ""
    
    // Coffee shop variables
//    @State private var name: String
//    @State private var address: String
//    @State private var openingTime: Date
//    @State private var closingTime: Date
//    @State private var decafAvailable: Bool
//    @State private var local: Bool
    
    // Optional coffee shop in initializer if adding review directly from coffee shop detail page view
    init(reviewViewModel: ReviewViewModel, shopViewModel: CoffeeShopViewModel) {
        
        self.reviewViewModel = reviewViewModel
        self.shopViewModel = shopViewModel
        
        // Initialize coffee shop properties if coffeeShop in initializer
//        self.name = shop?.name ?? "Unknown"
//        self.address = shop?.address ?? "Unknown"
//        self.openingTime = shop?.openingTime ?? Date.now
//        self.closingTime = shop?.closingTime ?? Date.now
//        self.decafAvailable = shop?.decafAvailable ?? false
//        self.local = shop?.local ?? false
            
    }
    
    private var shop: CoffeeShop? {
        shopViewModel.shops.first(where: { $0.id == reviewViewModel.shopId })
    }
    
    // Editable shop review variables
    @State private var coffee: Int = 0
    @State private var espresso: Int = 0
    @State private var nonCoffeeDrinks: Int = 0
    @State private var safety: Int = 0
    @State private var wifi: Int = 0
    @State private var seating: Int = 0
    @State private var quiet: Int = 0
    @State private var parking: Int = 0
    @State private var food: Int = 0
    @State private var value: Int = 0
    @State private var cleanliness: Int = 0
    @State private var staff: Int = 0
    @State private var comment = ""
    
    var body: some View {
        NavigationStack {
            
            if let coffeeShop = shop {
                VStack {
                    
                    Form {
                        
                        Section("Coffee Shop Info") {
                            
                            HStack(alignment: .top) {
                                Text("Name:")
                                    .bold()
                                Text("\(coffeeShop.name)")
                            }
                            
                            HStack(alignment: .top) {
                                Text("Address:")
                                    .bold()
                                Text("\(coffeeShop.address)")
                            }
                            
                            HStack(alignment: .top) {
                                Text("Hours:")
                                    .bold()
                                Text("\(formattedTime(coffeeShop.openingTime)) - \(formattedTime(coffeeShop.closingTime))")
                            }
                            
                            HStack(alignment: .top) {
                                Text("Decaf Available:")
                                    .bold()
                                if coffeeShop.decafAvailable {
                                    Text("Yes")
                                        .foregroundStyle(.green)
                                } else {
                                    Text("No")
                                        .foregroundStyle(.red)
                                }
                            }
                            
                            HStack(alignment: .top) {
                                Text("Local:")
                                    .bold()
                                if coffeeShop.local {
                                    Text("Yes")
                                        .foregroundStyle(.green)
                                } else {
                                    Text("No")
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                        
                        // Shop review inputs
                        Section("Write a review") {
                            HStack {
                                Text("Coffee")
                                Spacer()
                                RatingView(rating: $coffee)
                            }
                            
                            HStack {
                                Text("Espresso")
                                Spacer()
                                RatingView(rating: $espresso)
                            }
                            
                            HStack {
                                Text("Non-Coffee Drinks")
                                Spacer()
                                RatingView(rating: $nonCoffeeDrinks)
                            }
                            
                            HStack {
                                Text("Safety")
                                Spacer()
                                RatingView(rating: $safety)
                            }
                            
                            HStack {
                                Text("WiFi")
                                Spacer()
                                RatingView(rating: $wifi)
                            }
                            
                            HStack {
                                Text("Seating")
                                Spacer()
                                RatingView(rating: $seating)
                            }
                            
                            HStack {
                                Text("Quiet")
                                Spacer()
                                RatingView(rating: $quiet)
                            }
                            
                            HStack {
                                Text("Parking")
                                Spacer()
                                RatingView(rating: $parking)
                            }
                            
                            HStack {
                                Text("Food")
                                Spacer()
                                RatingView(rating: $food)
                            }
                            
                            HStack {
                                Text("Value")
                                Spacer()
                                RatingView(rating: $value)
                            }
                            
                            HStack {
                                Text("Cleanliness")
                                Spacer()
                                RatingView(rating: $cleanliness)
                            }
                            
                            HStack {
                                Text("Service")
                                Spacer()
                                RatingView(rating: $staff)
                            }
                            
                            ZStack(alignment: .leading) {
                                TextEditor(text: $comment)
                                if comment.isEmpty {
                                    Text("Add additional comments here...\n\n")
                                        .foregroundStyle(.gray)
                                }
                            }
                            
                        }
                        
                        Section {
                            Button("Save") {
                                // Check for valid review before saving review and potentially new coffee shop
                                if validReview() {
                                    
                                    Task {
                                        try await reviewViewModel.createReview(coffeeRating: coffee, espressoRating: espresso, nonCoffeeDrinkRating: nonCoffeeDrinks, safetyRating: safety, wifiRating: wifi, seatingRating: seating, quietRating: quiet, parkingRating: parking, foodRating: food, valueRating: value, cleanlinessRating: cleanliness, staffRating: staff, comment: comment, createTime: Date.now, modifyTime: Date.now)
                                        
                                        await shopViewModel.fetchAllShops()
                                    }
                                    
                                    dismiss()
                                    
                                }
                            }
                            .listRowBackground(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                            .foregroundStyle(.black)
                            .bold()
                            .frame(maxWidth: .infinity)   // expands hit area
                            .multilineTextAlignment(.center)
                        }
                        
                    }
                    .navigationTitle("Add Review")
                    .navigationBarTitleDisplayMode(.inline)
                    .tint(.none)
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                    }
                }
                
            } else {
                Text("Coffee shop loading...")
            }
        }
    }
    
    // Ensure shop name, address, and all review attributes except for comment have a value/are selected before saving
    func validReview() -> Bool {
        if (coffee == 0 && espresso == 0 && nonCoffeeDrinks == 0 && safety == 0 && wifi == 0 && seating == 0 && quiet == 0 && parking == 0 && food == 0 && value == 0 && cleanliness == 0 && staff == 0 && comment == "") {
            errorMessage = "At least one review attribute must be entered."
            return false
        }
        
        return true
    }
    
    // Helper function to format date as time only
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
//
//
//#Preview {
//    
//    do {
//        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: CoffeeShop.self, configurations: config)
//        let exampleUser = User()
//        let exampleShop = CoffeeShop()
//        
//        return AddReviewView(user: exampleUser, coffeeShop: exampleShop)
//            .modelContainer(container)
//        
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
//}

