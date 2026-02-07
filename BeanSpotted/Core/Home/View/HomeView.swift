//
//  FooterView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 1/11/26.

import SwiftData
import SwiftUI

enum ShopSort: String, CaseIterable {
    case nameAZ = "Name (A-Z)"
    case ratingDesc = "Rating (High-Low)"
    case reviewCountDesc = "Review Count (High-Low)"
}


struct HomeView: View {
    
    @State private var path = NavigationPath()
    @StateObject var shopViewModel = CoffeeShopViewModel()
    
    @State private var sort: ShopSort = .nameAZ
    @State private var filters: [String: Int] = [
        "Overall": 0,
        "Coffee": 0,
        "Espresso": 0,
        "Non-Coffee Drinks": 0,
        "Safety": 0,
        "WiFi": 0,
        "Seating": 0,
        "Quiet": 0,
        "Parking": 0,
        "Food": 0,
        "Value": 0,
        "Cleanliness": 0,
        "Service": 0
    ]
    
    let filterNames = ["Overall", "Coffee", "Espresso", "Non-Coffee Drinks", "Safety", "WiFi", "Seating", "Quiet", "Parking", "Food", "Value", "Cleanliness", "Service"]
    
    @State private var searchText = ""
    
    
    //let filters = ["Decaf Available", "Local Only"]
//    @State private var selectedFilters = [String]()
    
    //@State private var searchText = ""
    
    private var filtered: [CoffeeShop] {
        shopViewModel.shops
            .filter { shop in
                let cleanedSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                
                // Filter by search criteria
                if !cleanedSearch.isEmpty {
                    let nameMatch = shop.name.lowercased().contains(cleanedSearch)
                    let addressMatch = shop.address.lowercased().contains(cleanedSearch)
                    if !nameMatch && !addressMatch { return false }
                }
                
                // Filter by min ratings
                if shop.avgOverallRating < Double(filters["Overall"] ?? -1) { return false }
                if shop.avgCoffeeRating < Double(filters["Coffee"] ?? -1) { return false }
                if shop.avgEspressoRating < Double(filters["Espresso"] ?? -1) { return false }
                if shop.avgNonCoffeeDrinkRating < Double(filters["Non-Coffee Drinks"] ?? -1) { return false }
                if shop.avgStaffRating < Double(filters["Safety"] ?? -1) { return false }
                if shop.avgWifiRating < Double(filters["WiFi"] ?? -1) { return false }
                if shop.avgSeatingRating < Double(filters["Seating"] ?? -1) { return false }
                if shop.avgQuietRating < Double(filters["Quiet"] ?? -1) { return false }
                if shop.avgParkingRating < Double(filters["Parking"] ?? -1) { return false }
                if shop.avgFoodRating < Double(filters["Food"] ?? -1) { return false }
                if shop.avgValueRating < Double(filters["Value"] ?? -1) { return false }
                if shop.avgCleanlinessRating < Double(filters["Cleanliness"] ?? -1) { return false }
                if shop.avgStaffRating < Double(filters["Service"] ?? -1) { return false }
                
                return true
            }
            .sorted { a, b in
                switch sort {
                case .nameAZ:
                    return a.name.localizedCaseInsensitiveCompare(b.name) == .orderedAscending
                case .ratingDesc:
                    if a.avgOverallRating != b.avgOverallRating { return a.avgOverallRating > b.avgOverallRating }
                    return a.name < b.name
                case .reviewCountDesc:
                    if a.reviewCount != b.reviewCount { return a.reviewCount > b.reviewCount }
                    return a.name < b.name
                }
            }
        
        // Return all coffee shops without filter if nothing in search
//        guard !cleanedSearch.isEmpty else { return shopViewModel.shops }
//        return shopViewModel.shops.filter {
//            $0.name.lowercased().contains(cleanedSearch) || $0.address.lowercased().contains(cleanedSearch)
//        }
    }
    
    @State private var showingAddShopScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                
                ForEach(filtered) { shop in
                    NavigationLink(destination: DetailView(coffeeShop: shop, shopViewModel: shopViewModel)) {
    //
                        HStack {
                            // Vertically display coffee shop name, city, and state on left of each row
                            VStack(alignment: .leading) {
                                Spacer()
                                Text(shop.name)
                                    .font(.headline)
                                Text("\(shop.city), \(shop.state)")
    
                                if shop.reviewCount == 1 {
                                    Text("\(shop.reviewCount) Review")
                                } else {
                                    Text("\(shop.reviewCount) Reviews")
                                }
                                Spacer()
                            }
                            
                            Spacer()

                            // Display star rating on right of each row
                            RatingDisplayView(rating: shop.avgOverallRating)
                        }
                    }
                }
    //            .onDelete(perform: deleteShops)
            }
            .navigationTitle("Bean Spots")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, prompt: "Search coffee shop")
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .overlay {
                if filtered.isEmpty {
                    ContentUnavailableView("No results", systemImage: "person.fill.questionmark")
                }
            }
            .sheet(isPresented: $showingAddShopScreen) {
                AddShopView(shopViewModel: shopViewModel)
            }
            .toolbar {
                //Navigation to add new shop
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddShopScreen.toggle()
                    } label: {
                        Image(systemName: "plus.app.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            .foregroundStyle(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        ForEach(filterNames, id: \.self) { key in
                            Button(action: {
                                if filters[key] == 4 {
                                    filters[key] = 0
                                }
                                else {
                                    filters[key] = 4
                                }
                            }) {
                                HStack {
                                    if filters[key] == 4 {
                                        Image(systemName: "checkmark")
                                    }
                                    Spacer()
                                    Text("\(key): 4+ stars")
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundStyle(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Picker("Sort", selection: $sort) {
                            ForEach(ShopSort.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundStyle(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                    }
                }
            }
        }
    }
}

#Preview {
//    do {
//        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: User.self, configurations: config)
//        let exampleUser = User()
//        
        HomeView()
//            .modelContainer(container)
//        
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
}
