//
//  FooterView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 1/11/26.

import SwiftUI
import CoreLocation

enum ShopSort: String, CaseIterable {
    case nameAZ = "Name (A-Z)"
    case ratingDesc = "Rating (High-Low)"
    case reviewCountDesc = "Review Count (High-Low)"
    case distanceDesc = "Distance (Near-Far)"
}


struct HomeView: View {
    
    @State private var path = NavigationPath()
    //@StateObject var shopViewModel = CoffeeShopViewModel()
    @ObservedObject var shopViewModel: CoffeeShopViewModel
    @ObservedObject var savedShopViewModel: SavedShopViewModel
    @StateObject private var locationManager = LocationManager()
    @State private var distanceFromShopId: [String: Double] = [:]
    
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
                
                Task {
                   // Only compute once per shop
                    guard distanceFromShopId[shop.id] == nil else { return }
                    guard let userLoc = locationManager.location else { return }

                   do {
                       let shopCoord = try await geocodeAddress(shop.id)
                       let shopLoc = CLLocation(latitude: shopCoord.latitude, longitude: shopCoord.longitude)
                       let meters = userLoc.distance(from: shopLoc)
                       let miles = meters / 1609.344

                       //let formattedDistance = formattedDistance(meters: distance)
                       distanceFromShopId[shop.id] = miles

//                       let reviewsText = shop.reviewCount == 1 ? "(1 Review)" : "(\(shop.reviewCount) Reviews)"
//                       distanceTextByShopId[shop.id] = "\(formattedDistance) \(reviewsText)"
                   } catch {
                       print("GEOCODE FAILED for:", shop.address)
                           print("ERROR:", error)
                   }
                }
                
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
                case .distanceDesc:
                    if distanceFromShopId[a.id] != distanceFromShopId[b.id] { return distanceFromShopId[a.id] ?? 0 < distanceFromShopId[b.id] ?? 0}
                    return a.name < b.name
                }
            }
    }
    
    func geocodeAddress(_ address: String) async throws -> CLLocationCoordinate2D {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.geocodeAddressString(address)

        guard let coordinate = placemarks.first?.location?.coordinate else {
            throw NSError(domain: "Geocode", code: 0, userInfo: [NSLocalizedDescriptionKey: "No coordinate found"])
        }
        return coordinate
    }

    func distanceInMeters(user: CLLocationCoordinate2D, shop: CLLocationCoordinate2D) -> CLLocationDistance {
        let userLoc = CLLocation(latitude: user.latitude, longitude: user.longitude)
        let shopLoc = CLLocation(latitude: shop.latitude, longitude: shop.longitude)
        return userLoc.distance(from: shopLoc) // meters
    }
    
//    func formattedDistance(meters: CLLocationDistance) -> Double {
//        let formatter = MeasurementFormatter()
//        formatter.unitOptions = .providedUnit
//        formatter.numberFormatter.maximumFractionDigits = 1
//
//        let measurement = Measurement(value: meters, unit: UnitLength.meters)
//
//        // choose miles or km depending on locale, or force one:
//        return Double(measurement.converted(to: .miles)
//        //return formatter.string(from: output)
//    }
    
    @State private var showingAddShopScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                
                ForEach(filtered) { shop in
                    
                    let shopId = shop.id
                        
                    NavigationLink {
                        DetailViewWrapper(shopId: shopId, shopViewModel: shopViewModel, savedShopViewModel: savedShopViewModel)
    
                    } label: {
                        //
                        HStack {
                            // Vertically display coffee shop name, city, and state on left of each row
                            VStack(alignment: .leading) {
                                Spacer()
                                Text(shop.name)
                                    .font(.headline)
                                Text("\(shop.city), \(shop.state)")
                                
                                let reviewsText = shop.reviewCount == 1 ? "(1 Review)" : "(\(shop.reviewCount) Reviews)"
                                
                                if let miles = distanceFromShopId[shopId] {
                                    Text("\(String(format: "%.1f", miles)) mi, \(reviewsText)")
                                } else {
                                    Text("\(reviewsText)")
                                }
                                    //.foregroundStyle(.secondary)
                                //Text(distanceTextByShopId(shopId))
                                
//                                    if shop.reviewCount == 1 {
//                                        Text("\(shop.reviewCount) Review, \(String(describing: formattedDistance)) mi")
//                                    } else {
//                                        Text("\(shop.reviewCount) Reviews, \(String(describing: formattedDistance)) mi")
//                                    }
                                
                                Spacer()
                            }
                            
                            Spacer()
                            
                            // Display star rating on right of each row
                            RatingDisplayView(rating: shop.avgOverallRating)
                        }
                    }
                    .task {
//                        Task {
//                           // Only compute once per shop
//                            //guard distanceFromShopId[shop.id] == nil else { return }
//                            guard let userLoc = locationManager.location else { return }
//                            guard distanceFromShopId[shop.id] == nil else { return }
//
//                           do {
//                               let shopCoord = try await geocodeAddress(shop.id)
//                               let shopLoc = CLLocation(latitude: shopCoord.latitude, longitude: shopCoord.longitude)
//                               let meters = userLoc.distance(from: shopLoc)
//                               let miles = meters / 1609.344
//
//                               //let formattedDistance = formattedDistance(meters: distance)
//                               distanceFromShopId[shop.id] = miles
//
//        //                       let reviewsText = shop.reviewCount == 1 ? "(1 Review)" : "(\(shop.reviewCount) Reviews)"
//        //                       distanceTextByShopId[shop.id] = "\(formattedDistance) \(reviewsText)"
//                           } catch {
//                               print("GEOCODE FAILED for:", shop.address)
//                                   print("ERROR:", error)
//                           }
//                        }
                    }
                }
    //            .onDelete(perform: deleteShops)
            }
            .task {
                locationManager.requestLocation()
            }
            .navigationTitle("Bean Spots")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, prompt: "Search by name, location, or address")
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
//        HomeView()
//            .modelContainer(container)
//        
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
}
