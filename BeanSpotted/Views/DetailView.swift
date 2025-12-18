//
//  DetailView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/26/24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var coffeeShops: [CoffeeShop]
    @Query var users: [User]
    
    let coffeeShop: CoffeeShop
    
    // Favorite bool and images
    //@State private var favOn = false
    var favOffImage = Image(systemName: "heart")
    var favOnImage = Image(systemName: "heart.fill")
    
    // Have Been bool and images
    //@State private var beenOn = false
    var beenOffImage = Image(systemName: "arrowshape.left")
    var beenOnImage = Image(systemName: "arrowshape.left.fill")
    
    // Want To Go bool and images
    //@State private var toGoOn = false
    var toGoOffImage = Image(systemName: "flag")
    var toGoOnImage = Image(systemName: "flag.fill")
    
    // Off and on saved button colors
    var offColor = Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255)
    var onColor = Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255)
    
    var body: some View {
        VStack(alignment: .leading) {
            
            List {
                
                Section("Shop Info") {
//                    HStack(alignment: .top) {
//                        Text("Name:")
//                            .bold()
//                        Text(coffeeShop.name)
//                    }
                    
                    HStack(alignment: .top) {
                        Text("Address:")
                            .bold()
                        Text(coffeeShop.address)
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
                                //.foregroundStyle(Color(.sRGB, red: 211/255, green: 4/255, blue: 4/255))
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
                                //.foregroundStyle(Color(.sRGB, red: 211/255, green: 4/255, blue: 4/255))
                        }
                    }
                }
                
                Section("Review Summary") {
                    HStack {
                        Text("Overall")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)
                        Spacer()
                        // ********
                        RatingDisplayView(rating: coffeeShop.avgRating)
                    }
                    .listRowBackground(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))

                    HStack {
                        Text("Coffee")
                        Spacer()
                        RatingDisplayView(rating: coffeeShop.averageCoffeeRating())
                    }
                    
                    HStack {
                        Text("Non-Coffee Drinks")
                        Spacer()
                        RatingDisplayView(rating: coffeeShop.averageNonCoffeeDrinkRating())
                    }
                    
                    HStack {
                        Text("Safety")
                        Spacer()
                        RatingDisplayView(rating: coffeeShop.averageSafetyRating())
                    }
                    
                    HStack {
                        Text("Wifi Quality")
                        Spacer()
                        RatingDisplayView(rating: coffeeShop.averageWifiQualityRating())
                    }
                    
                    HStack {
                        Text("Seating")
                        Spacer()
                        RatingDisplayView(rating: coffeeShop.averageSeatingRating())
                    }
                    
                    HStack {
                        Text("Quiet")
                        Spacer()
                        RatingDisplayView(rating: coffeeShop.averageQuietRating())
                    }
                    
                    HStack {
                        Text("Parking")
                        Spacer()
                        RatingDisplayView(rating: coffeeShop.averageParkingRating())
                    }
                    
                    HStack {
                        Text("Food")
                        Spacer()
                        RatingDisplayView(rating: coffeeShop.averageFoodRating())
                    }
                    
                    HStack {
                        Text("Value")
                        Spacer()
                        RatingDisplayView(rating: coffeeShop.averageValueRating())
                    }
                    
                    HStack {
                        Text("Cleanliness")
                        Spacer()
                        RatingDisplayView(rating: coffeeShop.averageCleanlinessRating())
                    }
                    
                    HStack {
                        Text("Staff Friendliness")
                        Spacer()
                        RatingDisplayView(rating: coffeeShop.averageStaffFriendlinessRating())
                    }
                }
                
                Section("Detailed Reviews") {
                    ForEach(coffeeShop.reviews.reversed()) { review in
                        VStack {
                            
                            Spacer()
                            
                            HStack {
                                Text("\(review.user?.username ?? "Anonymous")")
                                    .bold()
                                Spacer()
                                
                                //distance = Date.now().distance(to: review.createTime)
                                //let seconds = Date.now().timeIntervalSince(review.createTime)
                                //Date.now().timeIntervalSince(review.createTime) < 86400
                                
                                let startOfDay = Calendar.current.startOfDay(for: review.createTime)
                                
                                if Date.now.timeIntervalSince(startOfDay) < 86400 {
                                    Text("Today at \(formattedTime(review.createTime))")
                                    
                                } else if Date.now.timeIntervalSince(startOfDay) < 172800 {
                                    Text("Yesterday")
                                    
                                } else if Date.now.timeIntervalSince(startOfDay) < 604800 {
                                    Text("Last Week")
                                    
                                } else {
                                    Text("\(formattedDate(review.createTime))")
                                }
//                                Text("\(review.createTime.formatted())")
                                //Text("\(review.createTime.formatted(date: .short, time: .none)), \(formattedTime(review.createTime))")
                            }
                            
                            HStack {
                                RatingDisplayView(rating: review.overallRating)
                                Spacer()
                            }
                            
                            Spacer()
                            
                            HStack {
                                Text(review.comment)
                                Spacer()
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button {
                        if users.isEmpty ? false : !users[0].wantToGo.contains(where: { $0.id == coffeeShop.id }) {
                            users[0].wantToGo.append(coffeeShop)
                            
                        } else if users.isEmpty ? false : users[0].wantToGo.contains(where: { $0.id == coffeeShop.id }) {
                            users[0].wantToGo.removeAll { $0 == coffeeShop }
                        }
                        
                        do {
                            try modelContext.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                        // Reinvoked each time button is pressed
                    } label: {
                        if users.isEmpty ? false : users[0].wantToGo.contains(where: { $0.id == coffeeShop.id }) {
                            toGoOnImage
                                .foregroundStyle(onColor)
                        } else {
                            toGoOffImage
                                .foregroundStyle(offColor)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button {
                        if users.isEmpty ? false : !users[0].haveBeen.contains(where: { $0.id == coffeeShop.id }) {
                            users[0].haveBeen.append(coffeeShop)
                            
                        } else if users.isEmpty ? false : users[0].haveBeen.contains(where: { $0.id == coffeeShop.id }) {
                            users[0].haveBeen.removeAll { $0 == coffeeShop }
                        }
                        
                        do {
                            try modelContext.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                        // Reinvoked each time button is pressed
                    } label: {
                        if users.isEmpty ? false : users[0].haveBeen.contains(where: { $0.id == coffeeShop.id }) {
                            beenOnImage
                                .foregroundStyle(onColor)
                        } else {
                            beenOffImage
                                .foregroundStyle(offColor)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button {
                        if users.isEmpty ? false : !users[0].favorites.contains(where: { $0.id == coffeeShop.id }) {
                            users[0].favorites.append(coffeeShop)
                            
                        } else if users.isEmpty ? false : users[0].favorites.contains(where: { $0.id == coffeeShop.id }) {
                            users[0].favorites.removeAll { $0 == coffeeShop }
                        }
                        
                        do {
                            try modelContext.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                        // Reinvoked each time button is pressed
                    } label: {
                        if users.isEmpty ? false : users[0].favorites.contains(where: { $0.id == coffeeShop.id }) {
                            favOnImage
                                .foregroundStyle(onColor)
                        } else {
                            favOffImage
                                .foregroundStyle(offColor)
                        }
                    }
                }
            }
        }
        .navigationTitle(coffeeShop.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Helper function to format date as time only
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // Helper function to format date as date and time
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

#Preview {
    do {
        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: CoffeeShop.self, configurations: config)
        let example = CoffeeShop()
        
        return DetailView(coffeeShop: example)
            .modelContainer(container)
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
