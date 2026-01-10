//
//  SavedDetailView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 12/17/25.
//

import SwiftData
import SwiftUI

struct SavedDetailView: View {
    
    var savedType: String
    var savedArray: [CoffeeShop]
    var image: Image
    let user: User
    
    var body: some View {
        NavigationStack {
            List() {
                if savedArray.count > 0 {
                    ForEach(savedArray, id: \.id) { shop in
                        NavigationLink(destination: DetailView(coffeeShop: shop, user: user)) {
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
                } else {
                    Text("No \(savedType) Yet")
                }
            }
            .navigationTitle("\(savedType)")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    image
                        .foregroundStyle(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                }
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
}

#Preview {
    do {
        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let exampleUser = User()
        let array = exampleUser.favorites
        let type = "Favorites"
        let image = Image(systemName: "heart.fill")
        
        return SavedDetailView(savedType: type, savedArray: array, image: image, user: exampleUser)
            .modelContainer(container)
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
