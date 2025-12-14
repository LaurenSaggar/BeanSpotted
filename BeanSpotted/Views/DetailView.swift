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
    
    let coffeeShop: CoffeeShop
    
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
                    ForEach(coffeeShop.reviews) { review in
                        VStack {
                            HStack {
                                Text("\(review.user?.username ?? "Anonymous")")
                                Spacer()
                                Text("\(formattedTime(review.createTime))")
                            }
                            
                            HStack {
                                RatingDisplayView(rating: coffeeShop.averageStaffFriendlinessRating())
                                Spacer()
                            }
                            
                            HStack {
                                Text(review.comment)
                                Spacer()
                            }
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
