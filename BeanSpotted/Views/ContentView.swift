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
    
    let filters = ["Decaf Available", "Local Only"]
    @State private var selectedFilters = [String]()
    
    var body: some View {
        NavigationStack {
            CoffeeShopView(sort: sortOrder, filter: selectedFilters)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu("Filter") {
                        ForEach(filters, id: \.self) { filter in
                            Button(action: {
                                if !selectedFilters.contains(filter) {
                                    selectedFilters.append(filter)
                                }
                                else {
                                    selectedFilters.removeAll(where: { $0 == filter })
                                }
                            }) {
                                HStack {
                                    if selectedFilters.contains(filter) {
                                        Image(systemName: "checkmark")
                                    }
                                    Spacer()
                                    Text("\(filter)")
//                                    Image(systemName: "checkmark")
//                                        .opacity(selectedFilters.contains(filter) ? 1.0 : 0.0)
                                }
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
            .preferredColorScheme(.light)
        }
    }
}

#Preview {
    ContentView()
}
