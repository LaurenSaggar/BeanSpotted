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
    let user: User
    let coffeeShop: CoffeeShop?
    //@Query var reviews: [Review]
    
    // Coffee shop variables
    @State private var name: String
    @State private var address: String
    @State private var openingTime: Date
    @State private var closingTime: Date
    @State private var decafAvailable: Bool
    @State private var local: Bool
    
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
                
                Section("Coffee Shop Info") {
                    
                    // If coffee shop exists, read and display shop info; else set coffee shop info
                    if let coffeeShop = coffeeShop {
                        
                        HStack(alignment: .top) {
                            Text("Name:")
                                .bold()
                            Text("\(name)")
                        }
                        
                        HStack(alignment: .top) {
                            Text("Address:")
                                .bold()
                            Text("\(address)")
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
                    
                    // Set coffee shop info
                    } else {
                        // Set name of coffee shop
                        TextField("Name of coffee shop", text: $name)
                        
                        // Set address of coffee shop
                        TextField("Address of coffee shop", text: $address)
                        
                        // DatePicker for opening time
                        DatePicker("Opening Time", selection: $openingTime, displayedComponents: .hourAndMinute)
                            .onAppear {}
                        
                        // DatePicker for closing time
                        DatePicker("Closing Time", selection: $closingTime, displayedComponents: .hourAndMinute)
                            .onAppear {}
                        
                        // Toggle for decaf available
                        Toggle("Is decaf available?", isOn: $decafAvailable)
                        
                        // Toggle for local
                        Toggle("Is the coffee shop local?", isOn: $local)
                        
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
                            
                            let newReview = Review(coffee: coffee, nonCoffeeDrinks: nonCoffeeDrinks, safety: safety, wifiQuality: wifiQuality, seating: seating, quiet: quiet, parking: parking, food: food, value: value, cleanliness: cleanliness, staffFriendliness: staffFriendliness, comment: comment, coffeeShop: nil, user: user)
//
//                            // Add new review to existing coffee shop if shop already exists
                            if let shopIndex = coffeeShops.firstIndex(where: { $0.name == name && $0.address == address } ) {
                                let shop = coffeeShops[shopIndex]
//                                shop.openingTime = openingTime
//                                shop.closingTime = closingTime
//                                shop.decafAvailable = decafAvailable
//                                shop.local = local
                                
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

                                modelContext.insert(newCoffeeShop)

                                newReview.coffeeShop = newCoffeeShop

                                newCoffeeShop.reviews.append(newReview)

                                let ratings = newCoffeeShop.reviews.map( {$0.overallRating} )

                                newCoffeeShop.avgRating = ratings.reduce(0, +) / Double(newCoffeeShop.reviews.count)
                                
                                do {
                                    try modelContext.save()

                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                            
                            dismiss()
                            
                        } else {
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
    
    // Optional coffee shop in initializer if adding review directly from coffee shop detail page view
    init(user: User, coffeeShop: CoffeeShop? = nil) {
        self.user = user
        self.coffeeShop = coffeeShop
        
        // Initialize coffee shop properties if coffeeShop in initializer
        if let coffeeShop = coffeeShop {
            self.name = coffeeShop.name
            self.address = coffeeShop.address
            self.openingTime = coffeeShop.openingTime
            self.closingTime = coffeeShop.closingTime
            self.decafAvailable = coffeeShop.decafAvailable
            self.local = coffeeShop.local
            
        } else {
            self.name = ""
            self.address = ""
            var openingTimeComponents = DateComponents()
                openingTimeComponents.year = Calendar.current.component(.year, from: Date())
                openingTimeComponents.month = Calendar.current.component(.year, from: Date())
                openingTimeComponents.day = Calendar.current.component(.year, from: Date())
                openingTimeComponents.hour = 8
                openingTimeComponents.minute = 0
            self.openingTime = Calendar.current.date(from: openingTimeComponents) ?? Date.now
            var closingTimeComponents = DateComponents()
                closingTimeComponents.year = Calendar.current.component(.year, from: Date())
                closingTimeComponents.month = Calendar.current.component(.year, from: Date())
                closingTimeComponents.day = Calendar.current.component(.year, from: Date())
                closingTimeComponents.hour = 17
                closingTimeComponents.minute = 0
            self.closingTime = Calendar.current.date(from: closingTimeComponents) ?? Date.now
            self.decafAvailable = true
            self.local = true
            
        }
    }
    
    // Ensure shop name, address, and all review attributes except for comment have a value/are selected before saving
    func validReview() -> Bool {
        if (name.isEmpty || address.isEmpty || coffee == 0.0 || nonCoffeeDrinks == 0.0 || safety == 0.0 || wifiQuality == 0.0 || seating == 0.0 || quiet == 0.0 || parking == 0.0 || food == 0.0 || value == 0 || cleanliness == 0.0 || staffFriendliness == 0.0 || comment.isEmpty) {
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
    
    do {
        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let exampleUser = User()
        //let exampleShop = CoffeeShop()
        
        return AddReviewView(user: exampleUser)
            .modelContainer(container)
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
    
//        .modelContainer(for: [CoffeeShop.self, Review.self, User.self])
    //AddReviewView(coffeeShops: .constant([CoffeeShop()]))
}

