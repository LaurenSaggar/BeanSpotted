//
//  FooterView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 1/11/26.
//
import SwiftData
import SwiftUI

struct HomeView: View {
    
    @State private var path = NavigationPath()
    @State private var sortOrder = SortDescriptor(\CoffeeShop.avgRating, order: .reverse)
    
    let filters = ["Decaf Available", "Local Only"]
    @State private var selectedFilters = [String]()
    var user: User
    
    var body: some View {
        NavigationStack {
            CoffeeShopView(sort: sortOrder, filter: selectedFilters, user: user).toolbar(.visible, for: .navigationBar)
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
                        Image(systemName: "slider.horizontal.3")
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
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundStyle(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                    }
                }
            }
            //.toolbarBackground(.visible, for: .automatic)
//            .toolbarBackground(.visible, for: .topBar)
            .preferredColorScheme(.dark)
            
        }
            
//            //FooterView(user: user, path: $path)
//            // 1. Set the background color (ShapeStyle can be Color, Gradient, etc.)
//            .toolbarBackground(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255), for: .bottomBar)
//            // 2. Force the background to always be visible (optional, but often needed)
//            .toolbarBackground(.visible, for: .bottomBar)
//            // 3. Adjust the color scheme for text/buttons to match the background
//            .toolbarColorScheme(.dark, for: .bottomBar)
            
    }
}

#Preview {
    do {
        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let exampleUser = User()
        //let exampleShop = CoffeeShop()
        
        //return FooterView(user: exampleUser, path: .constant(NavigationPath()))
        return HomeView(user: exampleUser)
            .modelContainer(container)
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
