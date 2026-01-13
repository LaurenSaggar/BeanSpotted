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
    var user: User
    
    var body: some View {
        VStack {
            NavigationStack {
                CoffeeShopView(sort: sortOrder, filter: selectedFilters, user: user).toolbar(.visible, for: .bottomBar)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu {
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
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .foregroundStyle(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Menu {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Average Customer Rating")
                                    .tag(SortDescriptor(\CoffeeShop.avgRating, order: .reverse))
                                
                                Text("Name")
                                    .tag(SortDescriptor(\CoffeeShop.name))
                                
                                Text("Create Time")
                                    .tag(SortDescriptor(\CoffeeShop.createTime, order: .reverse))
                            }
                        } label: {
                            Image(systemName: "arrow.down.square")
                                .foregroundStyle(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                        }
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        FooterView(user: user)
                        
                    }
                }
                // 1. Set the background color (ShapeStyle can be Color, Gradient, etc.)
                .toolbarBackground(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255), for: .bottomBar)
                // 2. Force the background to always be visible (optional, but often needed)
                .toolbarBackground(.visible, for: .bottomBar)
                // 3. Adjust the color scheme for text/buttons to match the background
                .toolbarColorScheme(.dark, for: .bottomBar)
                
            }
            .preferredColorScheme(.dark)
            
            //Spacer()
            
            //FooterView(user: user)
//                .toolbar(.visible, for: .bottomBar)
            
        }
        //.edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    do {
        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let example = User()
        
        return ContentView(user: example)
            .modelContainer(container)
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
//    ContentView()
}
