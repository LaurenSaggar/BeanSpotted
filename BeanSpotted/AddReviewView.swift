//
//  AddReviewView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/22/24.
//
import SwiftData
import SwiftUI

struct AddReviewView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query var coffeeShops: [CoffeeShop]
    //@Query var reviews: [Review]
    
    // Coffee shop variables
    @State private var name = ""
    @State private var address = ""
    @State private var openingTime = Date()
    @State private var closingTime = Date()
    @State private var decafAvailable = true
    @State private var local = true
    
    // Shop review variables
    @State private var coffee = 0
    @State private var nonCoffeeDrinks = 0
    @State private var safety = 0
    @State private var wifiQuality = 0
    @State private var seating = 0
    @State private var quiet = 0
    @State private var parking = 0
    @State private var food = 0
    @State private var value = 0
    @State private var cleanliness = 0
    @State private var staffFriendliness = 0
    @State private var comment = ""
    
    var body: some View {
        NavigationStack {
            Form {
                // Coffee shop inputs
                Section("Coffee Shop Info") {
                    // Set name of coffee shop
                    TextField("Name of coffee shop", text: $name)
                    // Set address of coffee shop
                    TextField("Address of coffee shop", text: $address)
                    
                    // DatePicker for opening time
                    DatePicker("Opening Time", selection: $openingTime, displayedComponents: .hourAndMinute)
                        .onAppear {
                            // Set default opening time
                            var components = Calendar.current.dateComponents([.hour, .minute], from: Date())
                            components.hour = 8
                            components.minute = 0
                            if let defaultOpeningTime = Calendar.current.date(from: components) {
                                openingTime = defaultOpeningTime
                            }
                        }
                    
                    // DatePicker for closing time
                    DatePicker("Closing Time", selection: $closingTime, displayedComponents: .hourAndMinute)
                        .onAppear {
                            // Set default closing time
                            var components = Calendar.current.dateComponents([.hour, .minute], from: Date())
                            components.hour = 17
                            components.minute = 0
                            if let defaultClosingTime = Calendar.current.date(from: components) {
                                closingTime = defaultClosingTime
                            }
                        }
                    
                    // Toggle for decaf available
                    Toggle("Is decaf available?", isOn: $decafAvailable)
                    
                    // Toggle for local
                    Toggle("Is the coffee shop local?", isOn: $local)
                }
                
                // Shop review inputs
                Section("Write a review") {
                    HStack {
                        Text("Coffee")
                        Spacer()
                        RatingView(rating: $coffee)
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
                        Text("Wifi Quality")
                        Spacer()
                        RatingView(rating: $wifiQuality)
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
                        Text("Staff Friendliness")
                        Spacer()
                        RatingView(rating: $staffFriendliness)
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
                        // Add logic to check for valid review and add review to modelContext
                        if validReview() {
                            
                            let newReview = Review(coffee: coffee, nonCoffeeDrinks: nonCoffeeDrinks, safety: safety, wifiQuality: wifiQuality, seating: seating, quiet: quiet, parking: parking, food: food, value: value, cleanliness: cleanliness, staffFriendliness: staffFriendliness, comment: comment)
//                            
//                            // Add new review to existing coffee shop if shop already exists
                            if let shopIndex = coffeeShops.firstIndex(where: { $0.name == name && $0.address == address } ) {
//                                newReview = Review(coffeeShop: coffeeShops[shopIndex], coffee: coffee, nonCoffeeDrinks: nonCoffeeDrinks, safety: safety, wifiQuality: wifiQuality, seating: seating, quiet: quiet, parking: parking, food: food, value: value, cleanliness: cleanliness, staffFriendliness: staffFriendliness, comment: comment)
//                                modelContext.insert(newReview)
                                coffeeShops[shopIndex].reviews.append(newReview)
//                            
//                            // Add new coffee shop if it doesn't yet exist and add new review to newly created coffee shop
                            } else {
                                let newCoffeeShop = CoffeeShop(name: name, address: address, openingTime: openingTime, closingTime: closingTime, decafAvailable: decafAvailable, local: local)
                                
                                modelContext.insert(newCoffeeShop)
                                newCoffeeShop.reviews.append(newReview)
                            }
                            
                            //let existingShopArray = coffeeShops.filter( { $0.name == name && $0.address == address } )
                            
                            // Add new coffee shop if it doesn't yet exist and add new review to newly created coffee shop
//                            if existingShopArray.isEmpty {
//                                let newCoffeeShop = CoffeeShop(name: name, address: address, openingTime: openingTime, closingTime: closingTime, decafAvailable: decafAvailable, local: local)
//                                
//                                modelContext.insert(newCoffeeShop)
//                                newCoffeeShop.reviews.append(newReview)
//                            
//                            //
//                            } else {
//                                
//                            }
                            
                            // Add coffee shop to coffee shops array only if it is net new
//                            if coffeeShopIsNew(name: name, address: address) {
//                                let newCoffeeShop = CoffeeShop(name: name, address: address, openingTime: openingTime, closingTime: closingTime, decafAvailable: decafAvailable, local: local)
//                                
//                                modelContext.insert(newCoffeeShop)
//                                newCoffeeShop.reviews.append(newReview)
//                                
//                            } else {
//                                let existingShopArray = coffeeShops.filter( { $0.name == name && $0.address == address } )
//                                existingShop.reviews.append(new)
//                            }

//                            let coffeeShop = coffeeShops.filter(
//                                for shop in coffeeShops {
//                                    if shop.name == name && shop.address == address {
//                                        return true
//                                    }
//                                }
//                            )
                            // Add review to reviews array regardless of if it is net new or not
                            
//                            let newReview = Review(coffeeShop: CoffeeShop(name: name, address: address, openingTime: openingTime, closingTime: closingTime, decafAvailable: decafAvailable, local: local), coffee: coffee, nonCoffeeDrinks: nonCoffeeDrinks, safety: safety, wifiQuality: wifiQuality, seating: seating, quiet: quiet, parking: parking, food: food, value: value, cleanliness: cleanliness, staffFriendliness: staffFriendliness, comment: comment)
//                            modelContext.insert(newReview)
                            
                            dismiss()
                        } else {
                            ()
                        }
                    }
                }
                
            }
            .navigationTitle("Add Review")
        }
    }
    
    // Ensure shop name, address, and all review attributes except for comment have a value/are selected before saving
    func validReview() -> Bool {
        if (name.isEmpty || address.isEmpty || coffee == 0 || nonCoffeeDrinks == 0 || safety == 0 || wifiQuality == 0 || seating == 0 || quiet == 0 || parking == 0 || food == 0 || value == 0 || cleanliness == 0 || staffFriendliness == 0 || comment.isEmpty) {
            return false
        }
        
        return true
    }
    
    // Returns true if coffee shop is net new (name + address combo is unique)
//    func coffeeShopIsNew(name: String, address: String) -> Bool {
//        
//        for shop in coffeeShops {
//            if shop.name == name && shop.address == address {
//                return false
//            }
//        }
//        return true
//    }
}

#Preview {
    AddReviewView()
    //AddReviewView(coffeeShops: .constant([CoffeeShop()]))
}

