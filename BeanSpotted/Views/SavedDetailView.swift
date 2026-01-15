//
//  SavedDetailView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 12/17/25.
//

import SwiftData
import SwiftUI

struct SavedDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var savedType: String
    let user: User
    @State private var savedArray: [CoffeeShop]
    @State private var image: Image
    @State private var color: Color
    
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
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Button { dismiss() } label: {
                            Image(systemName: "chevron.left")
                                .font(.headline)
                        }
                        
                        
                        Text(savedType)
                            .font(.largeTitle)
                            .bold()
                        
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(color)
                    }
                    .padding(.top, 16)
                }
            }
        }
    }
    
    init(savedType: String, user: User) {
        
        self.user = user
        
        if savedType == "Favorites" {
            self.savedType = "Favorites"
            self.savedArray = user.favorites
            self.image = Image(systemName: "heart.fill")
            self.color = Color(.sRGB, red: 250/255, green: 145/255, blue: 100/255)
        } else if (savedType == "Have Been") {
            self.savedType = "Have Been"
            self.savedArray = user.haveBeen
            self.image = Image(systemName: "arrowshape.left.fill")
            self.color = Color(.sRGB, red: 0/255, green: 150/255, blue: 300/255)
        } else {
            self.savedType = "Want To Go"
            self.savedArray = user.wantToGo
            self.image = Image(systemName: "flag.fill")
            self.color = Color(.sRGB, red: 100/255, green: 190/255, blue: 100/255)
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
        //let array = exampleUser.favorites
        let type = "Favorites"
        //let image = Image(systemName: "heart.fill")
        
        return SavedDetailView(savedType: type, user: exampleUser)
            .modelContainer(container)
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
