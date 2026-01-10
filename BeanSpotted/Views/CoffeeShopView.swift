//
//  CoffeeShopView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/28/24.
//
import SwiftData
import SwiftUI

struct CoffeeShopView: View {
    // ModelContext tracks when model objects are created/modified/deleted before save to ModelContainer at later point
    @Environment(\.modelContext) var modelContext
    
    // @Query queries model objects from SwiftUI view & stays up to date/reinvokes every time your data changes
    @Query var coffeeShops: [CoffeeShop]
    @Query var users: [User]
    let user: User
    
    @State private var searchText = ""
    
    private var filtered: [CoffeeShop] {
        let cleanedSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        // Return all coffee shops without filter if nothing in search
        guard !cleanedSearch.isEmpty else { return coffeeShops }
        return coffeeShops.filter {
            $0.name.lowercased().contains(cleanedSearch) || $0.address.lowercased().contains(cleanedSearch)
        }
    }
    
    @State private var showingAddReviewScreen = false
    
    var body: some View {
        
        List() {
            
            ForEach(filtered) { shop in
                NavigationLink(destination: DetailView(coffeeShop: shop)) {
                    HStack {
                        // Vertically display coffee shop name and hours on left of each row
                        VStack(alignment: .leading) {
                            Text(shop.name)
                                .font(.headline)
                            Text("\(formattedTime(shop.openingTime)) - \(formattedTime(shop.closingTime))")
                            Text("Reviews: \(shop.reviews.count)")
                        }
                        
                        Spacer()
                        
                        // *******
                        // Display star rating on right of each row
                        RatingDisplayView(rating: shop.avgRating)
                    }
                }
            }
            .onDelete(perform: deleteShops)
        }
        .navigationTitle("Bean Spots")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $searchText, prompt: "Search coffee shop (name or address)")
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.never)
        .overlay {
            if filtered.isEmpty {
                ContentUnavailableView("No results", systemImage: "person.fill.questionmark")
            }
        }
        // Navigation to user profile
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: ProfileView(user: user)) {
                    Image(systemName: "person.fill")
                        .foregroundStyle(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                }
            }
        }
        // Navigation to saved coffee shop view
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !users.isEmpty {
                    NavigationLink(destination: SavedView(user: user)) {
                        Image(systemName: "square.and.arrow.down.fill")
                            .foregroundStyle(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                    }
                }
            }
        }
        //Navigation to add new review
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddReviewScreen.toggle()
                } label: {
                    Image(systemName: "plus.app.fill")
                        .foregroundStyle(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                }
            }
        }
        .sheet(isPresented: $showingAddReviewScreen) {
            AddReviewView(user: user)
        }
    }
    
    // Initialize coffee shop view to change the query sort order based on what's passed in from content view
    init(sort: SortDescriptor<CoffeeShop>, filter: [String], user: User) {
        // Need to change the query object itself rather than the array inside of it, so access the underscored property
            
        if filter.isEmpty {
            _coffeeShops = Query(sort: [sort])
            
        }
        
        if filter.contains("Decaf Available") {
            _coffeeShops = Query(filter: #Predicate<CoffeeShop> {
                $0.decafAvailable
            }, sort: [sort])
        }
            
        if filter.contains("Local Only") {
            _coffeeShops = Query(filter: #Predicate<CoffeeShop> {
                $0.local
            }, sort: [sort])
        }
        
        if filter.contains("Decaf Available") && filter.contains("Local Only") {
            _coffeeShops = Query(filter: #Predicate<CoffeeShop> {
                $0.decafAvailable && $0.local
            }, sort: [sort])
        }
        
        self.user = user
    }
    
    // Helper function to format date as time only
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // Delete coffee shops at offsets in model array
    func deleteShops(at offsets: IndexSet) {
        for offset in offsets {
            let shop = coffeeShops[offset]
            modelContext.delete(shop)
            
            do {
                try modelContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    
    do {
        let sortOrder = SortDescriptor(\CoffeeShop.name)
        let filters = ["None"]
        
        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let example = User()
        
        return CoffeeShopView(sort: sortOrder, filter: filters, user: example)
            .modelContainer(container)
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
