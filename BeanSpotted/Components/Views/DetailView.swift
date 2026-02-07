//
//  DetailView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/26/24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let coffeeShop: CoffeeShop
    @StateObject private var reviewViewModel: ReviewViewModel
    
    init(coffeeShop: CoffeeShop) {
        self.coffeeShop = coffeeShop
        _reviewViewModel = StateObject(wrappedValue: ReviewViewModel(shop: coffeeShop))
    }

    @State private var showingAddReviewScreen = false
    
    // Favorite images
    var favOffImage = Image(systemName: "heart")
    var favOnImage = Image(systemName: "heart.fill")
    var favoriteColor = Color(.sRGB, red: 250/255, green: 145/255, blue: 100/255)
    
    // Have Been images
    var beenOffImage = Image(systemName: "arrowshape.left")
    var beenOnImage = Image(systemName: "arrowshape.left.fill")
    var haveBeenColor = Color(.sRGB, red: 0/255, green: 150/255, blue: 300/255)
    
    // Want To Go images
    var toGoOffImage = Image(systemName: "flag")
    var toGoOnImage = Image(systemName: "flag.fill")
    
    // Off and on saved button colors
    var offColor = Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255)
    var onColor = Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255)
    var wantToGoColor = Color(.sRGB, red: 100/255, green: 190/255, blue: 100/255)
    
    var body: some View {
            
        List {
            
            Section("Shop Info") {
                
                HStack(alignment: .top) {
                    Text("Name:")
                        .bold()
                    Text(coffeeShop.name)
                }
                
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
            
            Section("Review Summary") {
                HStack {
                    Text("Overall")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.white)
                    Spacer()
                    RatingDisplayView(rating: coffeeShop.avgOverallRating)
                }
                .listRowBackground(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                
                HStack {
                    Text("Coffee")
                    Spacer()
                    RatingDisplayView(rating: coffeeShop.avgCoffeeRating)
                }
                
                HStack {
                    Text("Espresso")
                    Spacer()
                    RatingDisplayView(rating: coffeeShop.avgEspressoRating)
                }
                
                HStack {
                    Text("Non-Coffee Drinks")
                    Spacer()
                    RatingDisplayView(rating: coffeeShop.avgNonCoffeeDrinkRating)
                }
                
                HStack {
                    Text("Safety")
                    Spacer()
                    RatingDisplayView(rating: coffeeShop.avgSafetyRating)
                }
                
                HStack {
                    Text("Wifi Quality")
                    Spacer()
                    RatingDisplayView(rating: coffeeShop.avgWifiRating)
                }
                
                HStack {
                    Text("Seating")
                    Spacer()
                    RatingDisplayView(rating: coffeeShop.avgSeatingRating)
                }
                
                HStack {
                    Text("Quiet")
                    Spacer()
                    RatingDisplayView(rating: coffeeShop.avgQuietRating)
                }
                
                HStack {
                    Text("Parking")
                    Spacer()
                    RatingDisplayView(rating: coffeeShop.avgParkingRating)
                }
                
                HStack {
                    Text("Food")
                    Spacer()
                    RatingDisplayView(rating: coffeeShop.avgFoodRating)
                }
                
                HStack {
                    Text("Value")
                    Spacer()
                    RatingDisplayView(rating: coffeeShop.avgValueRating)
                }
                
                HStack {
                    Text("Cleanliness")
                    Spacer()
                    RatingDisplayView(rating: coffeeShop.avgCleanlinessRating)
                }
                
                HStack {
                    Text("Staff Friendliness")
                    Spacer()
                    RatingDisplayView(rating: coffeeShop.avgStaffRating)
                }
            }
            
            Section("Detailed Reviews") {
                
                ForEach(reviewViewModel.shopReviews.reversed()) { review in
                    VStack {
                        
                        Spacer()
                        
                        HStack {
                            Text(review.username)
                                .bold()
                            Spacer()
                            
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
                        }
                        
                        Spacer()
                        
                        HStack {
                            RatingDisplayView(rating: Double(review.overallRating))
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddReviewScreen.toggle()
                } label: {
                    Image(systemName: "plus.app.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .foregroundStyle(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                }
            }
        }
        .sheet(isPresented: $showingAddReviewScreen) {
            AddReviewView(reviewViewModel: reviewViewModel)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                
//                Button {
//                    if !user.wantToGo.contains(where: { $0.id == coffeeShop.id }) {
//                        user.wantToGo.append(coffeeShop)
//                        
//                    } else if user.wantToGo.contains(where: { $0.id == coffeeShop.id }) {
//                        user.wantToGo.removeAll { $0 == coffeeShop }
//                    }
//                    
//                    do {
//                        try modelContext.save()
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                    // Reinvoked each time button is pressed
//                } label: {
//                    if user.wantToGo.contains(where: { $0.id == coffeeShop.id }) {
//                        toGoOnImage
//                            .foregroundStyle(wantToGoColor)
//                    } else {
//                        toGoOffImage
//                            .foregroundStyle(wantToGoColor)
//                    }
//                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                
//                Button {
//                    if !user.haveBeen.contains(where: { $0.id == coffeeShop.id }) {
//                        user.haveBeen.append(coffeeShop)
//                        
//                    } else if user.haveBeen.contains(where: { $0.id == coffeeShop.id }) {
//                        user.haveBeen.removeAll { $0 == coffeeShop }
//                    }
//                    
//                    do {
//                        try modelContext.save()
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                    // Reinvoked each time button is pressed
//                } label: {
//                    if user.haveBeen.contains(where: { $0.id == coffeeShop.id }) {
//                        beenOnImage
//                            .foregroundStyle(haveBeenColor)
//                    } else {
//                        beenOffImage
//                            .foregroundStyle(haveBeenColor)
//                    }
//                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                
//                Button {
//                    if !user.favorites.contains(where: { $0.id == coffeeShop.id }) {
//                        user.favorites.append(coffeeShop)
//                        
//                    } else if user.favorites.contains(where: { $0.id == coffeeShop.id }) {
//                        user.favorites.removeAll { $0 == coffeeShop }
//                    }
//                    
//                    do {
//                        try modelContext.save()
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                    // Reinvoked each time button is pressed
//                } label: {
//                    if user.favorites.contains(where: { $0.id == coffeeShop.id }) {
//                        favOnImage
//                            .foregroundStyle(favoriteColor)
//                    } else {
//                        favOffImage
//                            .foregroundStyle(favoriteColor)
//                    }
//                }
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
//    do {
//        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: CoffeeShop.self, configurations: config)
//        let exampleShop = CoffeeShop()
//        let exampleUser = User()
//
//    DetailView(coffeeShop: )
//        return DetailView(coffeeShop: exampleShop, user: exampleUser)
//            .modelContainer(container)
//        
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
}
