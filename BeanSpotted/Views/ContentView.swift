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
//    @Environment(\.modelContext) var modelContext
//    
//    // @Query queries model objects from SwiftUI view & stays up to date/reinvokes every time your data changes
//    @Query var coffeeShops: [CoffeeShop]
//    
//    @State private var showingReviewScreen = false
    @State private var sortOrder = SortDescriptor(\CoffeeShop.avgRating, order: .reverse)
    
    var body: some View {
        NavigationStack {
            CoffeeShopView(sort: sortOrder)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu("Sort") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Average Customer Rating")
                                .tag(SortDescriptor(\CoffeeShop.avgRating, order: .reverse))
                            
                            Text("Name")
                                .tag(SortDescriptor(\CoffeeShop.name))
                            
                            Text("Create Time")
                                .tag(SortDescriptor(\CoffeeShop.createTime, order: .reverse))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
