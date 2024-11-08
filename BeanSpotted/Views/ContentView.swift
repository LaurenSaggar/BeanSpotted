//
//  ContentView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/14/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    @State private var sortOrder = SortDescriptor(\CoffeeShop.avgRating, order: .reverse)
    
    let filters = ["None", "Decaf Available", "Local Only"]
    @State private var selectedFilter = "None"
    
    var body: some View {
        NavigationStack {
            CoffeeShopView(sort: sortOrder, filter: selectedFilter)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu("Filter") {
                        Picker("Filter", selection: $selectedFilter) {
                            ForEach(filters, id: \.self) { filter in
                                Text(filter)
                            }
                        }
                    }
                }
                
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
