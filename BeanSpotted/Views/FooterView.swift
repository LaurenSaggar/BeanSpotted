//
//  FooterView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 1/11/26.
//
import SwiftData
import SwiftUI

struct FooterView: View {
    
    // ModelContext tracks when model objects are created/modified/deleted before save to ModelContainer at later point
    @Environment(\.modelContext) var modelContext
    
    // @Query queries model objects from SwiftUI view & stays up to date/reinvokes every time your data changes
    @Query var coffeeShops: [CoffeeShop]
    @Query var users: [User]
    let user: User
    
    var body: some View {

            HStack {
                
                Spacer()
                
                NavigationLink(destination: ContentView(user: user)) {
                    
                    VStack {
                        
                        Image(systemName: "house.fill")
                        //                                        .resizable()
                        //                                        .scaledToFit()
                        //                                        .containerRelativeFrame(.horizontal) { size, axis in
                        //                                            size * 0.07
                        //                                        }
                            .foregroundStyle(.black)
                        
                        Text("Home")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    }
                }
                
                Spacer()
                Spacer()
                
                NavigationLink(destination: SavedView(user: user)) {
                    
                    VStack {
                        Image(systemName: "square.and.arrow.down.fill")
                            .foregroundStyle(.black)
                        
                        Text("Saved")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    }
                }
                
                Spacer()
                Spacer()
                
                NavigationLink(destination: ProfileView(user: user)) {
                    
                    VStack {
                        Image(systemName: "person.fill")
                            .foregroundStyle(.black)
                        
                        Text("Profile")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    }
                }
                
                Spacer()
            }
            .padding(.top)
    }
}

#Preview {
    do {
        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let exampleUser = User()
        //let exampleShop = CoffeeShop()
        
        return FooterView(user: exampleUser)
            .modelContainer(container)
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
