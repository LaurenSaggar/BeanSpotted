//
//  ContentView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/14/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    // ModelContext tracks when model objects are created/modified/deleted before save to ModelContainer at later point
    @Environment(\.modelContext) var modelContext
    
    // @Query queries model objects from SwiftUI view & stays up to date/reinvokes every time your data changes
    @Query var coffeeShops: [CoffeeShop]
    
    @State private var showingReviewScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(coffeeShops) { shop in
                    VStack(alignment: .leading) {
                        Text(shop.name)
                            .font(.headline)
                        Text("\(formattedTime(shop.openingTime)) - \(formattedTime(shop.closingTime))")
                    }
                }
                .onDelete(perform: deleteShops)
            }
            .navigationTitle("Search")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Review") {
                        showingReviewScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingReviewScreen) {
                AddReviewView()
            }
        }
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
        }
    }
}

#Preview {
    ContentView()
}
