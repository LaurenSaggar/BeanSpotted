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
        case "Have Been": return Color(.sRGB, red: 0/255, green: 150/255, blue: 255/255)
            default: return Color(.sRGB, red: 100/255, green: 190/255, blue: 100/255)
        }
    }
    
    private var savedShops: [CoffeeShop] {
        
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
                        ForEach(savedShops.reversed()) { shop in
                            NavigationLink(destination: DetailView(shopId: shop.id, shopViewModel: shopViewModel, savedShopViewModel: savedShopViewModel)) {
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
