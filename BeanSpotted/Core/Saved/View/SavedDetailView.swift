//
//  SavedDetailView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 12/17/25.
//

import SwiftUI

struct SavedDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let savedType: String
    @ObservedObject var savedShopViewModel: SavedShopViewModel
    @ObservedObject var shopViewModel: CoffeeShopViewModel
    
    private var image: Image {
        switch savedType {
        case "Favorites": return Image(systemName: "heart.fill")
        case "Have Been": return Image(systemName: "arrowshape.left.fill")
        default: return Image(systemName: "flag.fill")
        }
    }
    
    private var color: Color {
        switch savedType {
        case "Favorites": return Color(.sRGB, red: 250/255, green: 145/255, blue: 100/255)
        case "Have Been": return Color(.sRGB, red: 0/255, green: 150/255, blue: 1.0) // <- note below
        default: return Color(.sRGB, red: 100/255, green: 190/255, blue: 100/255)
        }
    }
    
    private var savedShops: [CoffeeShop] {
        //        shopViewModel.shops
        //            .filter { shop in
        //                if savedType == "Favorites" {
        //                    return savedShopViewModel.haveBeen.contains { $0.id == shop.id }
        //                }
        //
        //                if savedType == "Have Been" {
        //                    return savedShopViewModel.haveBeen.contains { $0.id == shop.id }
        //                }
        //
        //                if savedType == "Want To Go" {
        //                    return savedShopViewModel.wantToGo.contains { $0.id == shop.id }
        //                }
        //
        //                return false
        //            }
        
        let ids: Set<String> = {
            switch savedType {
            case "Favorites": return Set(savedShopViewModel.favorites.compactMap { $0.id })
            case "Have Been": return Set(savedShopViewModel.haveBeen.compactMap { $0.id })
            default: return Set(savedShopViewModel.wantToGo.compactMap { $0.id })
            }
        }()
        
        return shopViewModel.shops.filter { ids.contains($0.id) }
    }
    
    //    let savedType: String
    //    var shops: [CoffeeShop]
    //    @State private var image: Image
    //    @State private var color: Color
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(savedType)
                        .font(.largeTitle)
                        .bold()
                    
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(color)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
                List {
                    
                    if !savedShops.isEmpty {
                        ForEach(savedShops) { shop in
                            //NavigationLink(destination: DetailView(coffeeShop: shop, shopViewModel: shopViewModel, savedShopViewModel: savedShopViewModel)) {
                            NavigationLink(destination: SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))) {
                                HStack {
                                    // Vertically display coffee shop name, city, and state on left of each row
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        Text(shop.name)
                                            .font(.headline)
                                        Text("\(shop.city), \(shop.state)")
                                        
                                        if shop.reviewCount == 1 {
                                            Text("\(shop.reviewCount) Review")
                                        } else {
                                            Text("\(shop.reviewCount) Reviews")
                                        }
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                    
                                    // Display star rating on right of each row
                                    RatingDisplayView(rating: shop.avgOverallRating)
                                }
                            }
                        }
                    } else {
                        Text("No \(savedType) Yet")
                    }
                }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button { dismiss() } label: {
                            Image(systemName: "chevron.left")
                                .font(.headline)
                        }
                    }
                }
            }
        }
    }
}
    
//    init(savedType: String, savedShopViewModel: SavedShopViewModel, shopViewModel: CoffeeShopViewModel) {
//        
//        self.savedShopViewModel = savedShopViewModel
//        self.shopViewModel = shopViewModel
//        self.savedType = savedType
//        
//        if savedType == "Favorites" {
//            let favoriteIDs = savedShopViewModel.favorites.map { $0.id }
//            self.shops = shopViewModel.shops.filter { favoriteIDs.contains( $0.id ) }
//            self.image = Image(systemName: "heart.fill")
//            self.color = Color(.sRGB, red: 250/255, green: 145/255, blue: 100/255)
//            
//        } else if (savedType == "Have Been") {
//            let haveBeenIDs = savedShopViewModel.haveBeen.map { $0.id }
//            self.shops = shopViewModel.shops.filter { haveBeenIDs.contains( $0.id ) }
//            self.image = Image(systemName: "arrowshape.left.fill")
//            self.color = Color(.sRGB, red: 0/255, green: 150/255, blue: 300/255)
//            
//        } else {
//            let wantToGoIDs = savedShopViewModel.wantToGo.map { $0.id }
//            self.shops = shopViewModel.shops.filter { wantToGoIDs.contains( $0.id ) }
//            self.image = Image(systemName: "flag.fill")
//            self.color = Color(.sRGB, red: 100/255, green: 190/255, blue: 100/255)
//        }
//        
//    }
    
    // Helper function to format date as time only
//    func formattedTime(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .none
//        formatter.timeStyle = .short
//        return formatter.string(from: date)
//    }
//
//#Preview {
//    do {
//        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: User.self, configurations: config)
//        let exampleUser = User()
//        let type = "Favorites"
//        
//        return SavedDetailView(savedType: type, user: exampleUser)
//            .modelContainer(container)
//        
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
//}
