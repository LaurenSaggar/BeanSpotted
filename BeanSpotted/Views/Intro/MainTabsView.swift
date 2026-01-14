//
//  MainTabsView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 1/14/26.
//

import SwiftData
import SwiftUI

enum AppTab: Hashable { case home, saved, profile }

struct MainTabsView: View {
    
    @State private var selectedTab: AppTab = .home
    
    // ModelContext tracks when model objects are created/modified/deleted before save to ModelContainer at later point
    @Environment(\.modelContext) var modelContext
    
    // @Query queries model objects from SwiftUI view & stays up to date/reinvokes every time your data changes
    @Query var coffeeShops: [CoffeeShop]
    @Query var users: [User]
    let user: User
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            HomeView(user: user)
                .tag(AppTab.home)
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                            .foregroundStyle(.black)
                        
                        Text("Home")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    }
                }
//                .toolbarBackground(.visible, for: .tabBar)
//                .toolbarBackground(Color.black, for: .tabBar)
            //            // 1. Set the background color (ShapeStyle can be Color, Gradient, etc.)
            //            .toolbarBackground(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255), for: .bottomBar)
            //            // 2. Force the background to always be visible (optional, but often needed)
            //            .toolbarBackground(.visible, for: .bottomBar)
            //            // 3. Adjust the color scheme for text/buttons to match the background
            //            .toolbarColorScheme(.dark, for: .bottomBar)
            
            SavedView(user: user)
                .tag(AppTab.saved)
                .tabItem {
                    VStack {
                        Image(systemName: "square.and.arrow.down.fill")
                            .foregroundStyle(.black)
                        
                        Text("Saved")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    }
                }
//                .toolbarBackground(.visible, for: .tabBar)
//                .toolbarBackground(Color.black, for: .tabBar)
            
            ProfileView(user: user, selectedTab: $selectedTab)
                .tag(AppTab.profile)
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                            .foregroundStyle(.black)
                        
                        Text("Profile")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    }
                }
//                .toolbarBackground(.visible, for: .tabBar)
//                .toolbarBackground(Color.black, for: .tabBar)
        }
        .tint(.white) // selected tab icon color
    }
}

#Preview {
    do {
        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let example = User()
        
        return MainTabsView(user: example)
            .modelContainer(container)
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
//    ContentView()
}
