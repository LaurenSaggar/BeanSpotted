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
    @Query var reviews: [Review]
    @Query var users: [User]
    //@Query var reviews: [Review]
    
    // Coffee shop variables
    @State private var name = ""
    @State private var address = ""
    @State private var openingTime = Date()
    @State private var closingTime = Date()
    @State private var decafAvailable = true
    @State private var local = true
    
    // Shop review variables
    @State private var coffee: Double = 0.0
    @State private var nonCoffeeDrinks: Double = 0.0
    @State private var safety: Double = 0.0
    @State private var wifiQuality: Double = 0.0
    @State private var seating: Double = 0.0
    @State private var quiet: Double = 0.0
    @State private var parking: Double = 0.0
    @State private var food: Double = 0.0
    @State private var value: Double = 0.0
    @State private var cleanliness: Double = 0.0
    @State private var staffFriendliness: Double = 0.0
    @State private var comment = ""
//    @State private var coffeeShop: CoffeeShop? = nil
    
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
                        // Check for valid review before saving review and potentially new coffee shop
                        if validReview() {
                            
                            let newReview = Review(coffee: coffee, nonCoffeeDrinks: nonCoffeeDrinks, safety: safety, wifiQuality: wifiQuality, seating: seating, quiet: quiet, parking: parking, food: food, value: value, cleanliness: cleanliness, staffFriendliness: staffFriendliness, comment: comment, coffeeShop: nil, user: nil)
//
//                            // Add new review to existing coffee shop if shop already exists
                            if let shopIndex = coffeeShops.firstIndex(where: { $0.name == name && $0.address == address } ) {
                                let shop = coffeeShops[shopIndex]
                                if !users.isEmpty {
                                    newReview.user = users[0]
                                }
                                shop.reviews.append(newReview)
                                let ratings = shop.reviews.map( {$0.overallRating} )
                                shop.avgRating = ratings.reduce(0, +) / Double(shop.reviews.count)
                                
                                do {
                                    try modelContext.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
//
//                            // Add new coffee shop if it doesn't yet exist and add new review to newly created coffee shop
                            } else {
                                let newCoffeeShop = CoffeeShop(name: name, address: address, openingTime: openingTime, closingTime: closingTime, decafAvailable: decafAvailable, local: local)
                                print(1)
                                modelContext.insert(newCoffeeShop)
                                print(2)
                                newReview.coffeeShop = newCoffeeShop
                                if !users.isEmpty {
                                    newReview.user = users[0]
                                }
                                newCoffeeShop.reviews.append(newReview)
                                print(3)
                                let ratings = newCoffeeShop.reviews.map( {$0.overallRating} )
                                print(4)
                                newCoffeeShop.avgRating = ratings.reduce(0, +) / Double(newCoffeeShop.reviews.count)
                                print(5)
                                
                                do {
                                    try modelContext.save()
                                    print(6)
                                } catch {
                                    print(error.localizedDescription)
                                    print(7)
                                }
                            }
                            
                            dismiss()
                            print(8)
                            
                        } else {
                            print(9)
                            ()
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
        }
    }
    
    // Ensure shop name, address, and all review attributes except for comment have a value/are selected before saving
    func validReview() -> Bool {
        if (name.isEmpty || address.isEmpty || coffee == 0.0 || nonCoffeeDrinks == 0.0 || safety == 0.0 || wifiQuality == 0.0 || seating == 0.0 || quiet == 0.0 || parking == 0.0 || food == 0.0 || value == 0 || cleanliness == 0.0 || staffFriendliness == 0.0 || comment.isEmpty) {
            return false
        }
        
        return true
    }
}


//@MainActor func previewFunc2() -> some View {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: CoffeeShop.self, Review.self, User.self, configurations: config)
//
//    for i in 1..<10 {
//        let coffeeShop = CoffeeShop(name: "Exaample \(i)", address: "12345", openingTime: Date.now, closingTime: Date.now, decafAvailable: true, local: true)
//        container.mainContext.insert(coffeeShop)
//        let review = Review(coffee: 4, nonCoffeeDrinks: 4, safety: 4, wifiQuality: 4, seating: 4, quiet: 4, parking: 4, food: 4, value: 4, cleanliness: 4, staffFriendliness: 4, comment: "Incredible!", coffeeShop: nil, user: nil)
//        container.mainContext.insert(review)
//        let user = User(firstName: "Lauren", lastName: "Saggar", username: "laurensaggar", password: "12345", bio: nil, createTime: Date.now, modifyTime: Date.now)
//        container.mainContext.insert(user)
//    }
//    
//    return AddReviewView()
//        .modelContainer(container)
//}


#Preview {
    
    AddReviewView()
//        .modelContainer(for: [CoffeeShop.self, Review.self, User.self])
    //AddReviewView(coffeeShops: .constant([CoffeeShop()]))
}

