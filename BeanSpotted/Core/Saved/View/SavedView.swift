//
//  SavedView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 11/5/25.
//

import SwiftUI

struct SavedView: View {
    
    @ObservedObject var shopViewModel: CoffeeShopViewModel
    @ObservedObject var savedShopViewModel: SavedShopViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                //.toolbar(.visible, for: .bottomBar))
                NavigationLink(destination: SavedDetailView(savedType: "Favorites", savedShopViewModel: savedShopViewModel, shopViewModel: shopViewModel)) {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.black)
                        
                        VStack(alignment: .leading) {
                            Text("Favorites")
                                .font(.title3)
                                .bold()
                            Text("\(savedShopViewModel.favorites.count) shops")
                        }
                        .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color(.sRGB, red: 250/255, green: 145/255, blue: 100/255))
                    .cornerRadius(24)
                }
                
                NavigationLink(destination: SavedDetailView(savedType: "Have Been", savedShopViewModel: savedShopViewModel, shopViewModel: shopViewModel)) {
                    HStack {
                        Image(systemName: "arrowshape.left.fill")
                            .foregroundStyle(.black)
                        
                        VStack(alignment: .leading) {
                            Text("Have Been")
                                .font(.title3)
                                .bold()
                            Text("\(savedShopViewModel.haveBeen.count) shops")
                        }
                        .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color(.sRGB, red: 0/255, green: 150/255, blue: 300/255))
                    .cornerRadius(24)
                }
                
                NavigationLink(destination: SavedDetailView(savedType: "Want To Go", savedShopViewModel: savedShopViewModel, shopViewModel: shopViewModel)) {
                    HStack {
                        Image(systemName: "flag.fill")
                            .foregroundStyle(.black)
                        
                        VStack(alignment: .leading) {
                            Text("Want To Go")
                                .font(.title3)
                                .bold()
                            Text("\(savedShopViewModel.wantToGo.count) shops")
                        }
                        .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color(.sRGB, red: 100/255, green: 190/255, blue: 100/255))
                    .cornerRadius(24)
                }
            }
            .padding()
            .navigationTitle("Saved Shops")
            
            Spacer()
        }
    }
}

#Preview {
    
//    do {
//        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: User.self, configurations: config)
//        let example = User()
//        
//        return SavedView(user: example)
//            .modelContainer(container)
//        
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
}
