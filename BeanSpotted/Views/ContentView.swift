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
            }
        }
        .preferredColorScheme(.dark)
    }
}

//@MainActor func previewFunc() -> some View {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: CoffeeShop.self, Review.self, User.self, configurations: config)
//
//    for i in 1..<10 {
//        let coffeeShop = CoffeeShop(name: "Exaample \(i)", address: "12345", openingTime: Date.now, closingTime: Date.now, decafAvailable: true, local: true)
//        container.mainContext.insert(coffeeShop)
//        let review = Review(coffee: 4, nonCoffeeDrinks: 4, safety: 4, wifiQuality: 4, seating: 4, quiet: 4, parking: 4, food: 4, value: 4, cleanliness: 4, staffFriendliness: 4, comment: "Incredible!", coffeeShop: nil, user: nil)
//        container.mainContext.insert(review)
//        let user = User(firstName: "Lauren", lastName: "Saggar", username: "laurensaggar", password: "12345", bio: nil, createTime: Date.now, modifyTime: Date.now)
//        container.mainContext.insert(user)
//    }
//    
//    return ContentView()
//        .modelContainer(container)
//}

#Preview {
    ContentView()
}
