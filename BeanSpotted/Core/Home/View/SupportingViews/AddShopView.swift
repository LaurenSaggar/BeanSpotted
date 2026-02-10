//
//  AddShopView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 1/20/26.


import SwiftUI
import MapKit
import CoreLocation

struct Place: Identifiable, Hashable {
    let id: UUID
    let name: String
    let latitude: Double
    let longitude: Double
    let streetNumber: String
    let streetName: String
    let city: String
    let state: String
    let postalCode: String

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var address: String {
        ("\(streetNumber) \(streetName), \(city), \(state) \(postalCode)")
    }
}


struct AddShopView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var shopViewModel: CoffeeShopViewModel
    
    // Shop location variables
    @StateObject private var locationManager = LocationManager()
    @State private var mapItems: [MKMapItem] = []
    @State private var places: [Place] = []
    @State private var position: MapCameraPosition = .automatic
    @State private var selectedPlace: Place? = nil
    
    // Set current and bounding regions to location of New York by default
    @State private var currentRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
            latitudinalMeters: 10_000,
            longitudinalMeters: 10_000
        )
    @State private var boundingRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
        latitudinalMeters: 10_000,
        longitudinalMeters: 10_000
    )
    
    // Coffee shop variables
    @State private var name: String
    @State private var address: String
    @State private var city: String
    @State private var state: String
    @State private var openingTime: Date
    @State private var closingTime: Date
    @State private var decafAvailable: Bool
    @State private var local: Bool
    @State private var errorMessage: String = ""
    @State private var showShopDetails: Bool = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                Map(position: $position, selection: $selectedPlace) {
                    ForEach(places, id: \.self) { place in
                        Marker(place.name, coordinate: place.coordinate)
                            .tag(place)
                    }
                }
                .task {
                    locationManager.requestLocation()
                }
                .onChange(of: locationManager.location) { _, loc in
                    guard let loc else { return }
                    let userRegion = MKCoordinateRegion(
                        center: loc.coordinate,
                        latitudinalMeters: 5_000,
                        longitudinalMeters: 5_000
                    )
                    
                    currentRegion = userRegion
                    //boundingRegion = userRegion
                    position = .region(userRegion)
                }
                .searchable(text: $searchText, prompt: "Search coffee shops")
                .onSubmit(of: .search) {
                    showShopDetails = false
                    let regionSnapshot = currentRegion
                    Task {
                        await searchCoffee(in: regionSnapshot)
                        position = .region(boundingRegion)
                    }
                }
                .onMapCameraChange(frequency: .onEnd) { context in
                    currentRegion = context.region
                    Task { await searchCoffee(in: context.region) }
                }
                .onChange(of: selectedPlace) { _, newPlace in
                    guard let p = newPlace else {return}
                    name = p.name
                    address = p.address
                    city = p.city
                    state = p.state
                    position = .region(MKCoordinateRegion(
                        center: p.coordinate,
                        latitudinalMeters: 200,
                        longitudinalMeters: 200
                    ))
                    showShopDetails = true
                    errorMessage = ""
                }
                
                    
                if showShopDetails {
                    
                    Form {
                        
                        // Set coffee shop info
                        Section("Coffee Shop Info") {
                            
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
                            
//                            // DatePicker for opening time
//                            DatePicker("Opening Time", selection: $openingTime, displayedComponents: .hourAndMinute)
//                                .onAppear {}
//
//                            // DatePicker for closing time
//                            DatePicker("Closing Time", selection: $closingTime, displayedComponents: .hourAndMinute)
//                                .onAppear {}
                            
                            // Toggle for decaf available
//                            Toggle("Is decaf available?", isOn: $decafAvailable)
                            
                            // Toggle for local
//                            Toggle("Is the coffee shop local?", isOn: $local)
                        }
                    }
                    .frame(height: 180)
                    
                    Button {
//                        if !coffeeShopExists() {
                        Task {
                            if !shopViewModel.shops.contains(where: { $0.name == name && $0.address == address}) {
                                try await shopViewModel.createShop(name: name, address: address, city: city, state: state, openingTime: openingTime, closingTime: closingTime, decafAvailable: decafAvailable, local: local)
                                
                                dismiss()
                                
                            } else {
                                errorMessage = "Coffee shop already exists"
                            }
                        }
                        
                    } label: {
                        Text("Save")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                            .cornerRadius(24)
                            .padding(.horizontal, 45)
                    }
                    
                    if !errorMessage.isEmpty {
                        Text("\(errorMessage)")
                    }
                    Spacer()
                }
            }
            .navigationTitle("Add Coffee Shop")
            .navigationBarTitleDisplayMode(.inline)
            .tint(.none)
        }
    }
    
    // Optional coffee shop in initializer if adding review directly from coffee shop detail page view
    init(shopViewModel: CoffeeShopViewModel) {
        
        // Initialize coffee shop properties
        self.name = ""
        self.address = ""
        self.city = ""
        self.state = ""
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
        self.shopViewModel = shopViewModel
    }
    
    // Checks if coffee shop already exists
//    func coffeeShopExists() -> Bool {
//        
//        if coffeeShops.firstIndex(where: { $0.name == name && $0.address == address }) != nil {
//            errorMessage = "That coffee shop already exists."
//            return true
//            
//        } else {
//            return false
//        }
//    }
    
    // Helper function to format date as time only
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // MKLocalSearch inputs include a natural language query and a region (important for “near me” results)
    @MainActor
    private func searchCoffee(in region: MKCoordinateRegion) async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = region
        currentRegion = region

        do {
            let response = try await MKLocalSearch(request: request).start()
            mapItems = response.mapItems
            boundingRegion = response.boundingRegion
            //position = .region(boundingRegion)
            places = mapItems.map {
                Place(id: UUID(), name: $0.name ?? "Coffee", latitude: $0.placemark.coordinate.latitude, longitude: $0.placemark.coordinate.longitude, streetNumber: $0.placemark.subThoroughfare ?? "Unknown", streetName: $0.placemark.thoroughfare ?? "Unknown", city: $0.placemark.locality ?? "Unknown", state: $0.placemark.administrativeArea ?? "Unknown", postalCode: $0.placemark.postalCode ?? "Unknown")
            }
        } catch {
            mapItems = []
            print("Search error:", error)
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
//        AddShopView()
//            .modelContainer(container)
//        
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
}

