//
//  UserView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 11/21/24.
//

import SwiftUI
import SwiftData

struct UserView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    //@Query var coffeeShops: [CoffeeShop]
    @Query var users: [User]
    
    // User variables
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var bio = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("User Information") {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    ZStack(alignment: .leading) {
                        TextEditor(text: $bio)
                        if bio.isEmpty {
                            Text("Share your personal bio...\n\n")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                
                Section {
                    Button("Save") {
                        
                        let newUser = User(firstName: firstName, lastName: lastName, bio: bio)
                        modelContext.insert(newUser)
                            
                        do {
                            try modelContext.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
        .navigationTitle("\(users[0].firstName)'s Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserView()
}
