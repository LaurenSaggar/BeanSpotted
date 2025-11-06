//
//  SavedView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 11/5/25.
//

import SwiftUI
import SwiftData

struct SavedView: View {
    
    // ModelContext tracks when model objects are created/modified/deleted before save to ModelContainer at later point
    @Environment(\.modelContext) var modelContext
    
    // @Query queries model objects from SwiftUI view & stays up to date/reinvokes every time your data changes
    @Query var users: [User]
    
    let user: User
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("Saved Shops") {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Have Been")
                                .font(.title3)
                                .bold()
                            Text("\(user.haveBeen.count) shops")
                        }
                        .foregroundStyle(.white)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .bold()
                            .foregroundStyle(.white)
                    }
                    .listRowBackground(Color(.sRGB, red: 44/255, green: 100/255, blue: 220/255))
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Want To Go")
                                .font(.title3)
                                .bold()
                            Text("\(user.wantToGo.count) shops")
                        }
                        .foregroundStyle(.white)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .bold()
                            .foregroundStyle(.white)
                    }
                    .listRowBackground(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Favorites")
                                .font(.title3)
                                .bold()
                            Text("\(user.favorites.count) shops")
                        }
                        .foregroundStyle(.white)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .bold()
                            .foregroundStyle(.white)
                    }
                    .listRowBackground(Color(.sRGB, red: 220/255, green: 145/255, blue: 100/255))
                }
            }
        }
        .navigationTitle("Saved")
    }
}

#Preview {
    do {
        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let example = User()
        
        return SavedView(user: example)
            .modelContainer(container)
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
