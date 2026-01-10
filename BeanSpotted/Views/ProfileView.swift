//
//  UserView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 11/21/24.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
//    @Binding var user: User
    @Query var users: [User]
    let user: User
    
    // User variables
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var bio = ""
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("User Information") {
                    
//                    TextField("\(users.isEmpty ? "First Name" : users[0].firstName)", text: $firstName)
                    TextField("\(user.firstName)", text: $firstName)
                    TextField("\(user.lastName)", text: $lastName)
                    TextField("\(user.username)", text: $username)
                    TextField("\(user.password)", text: $password)
                    
                    ZStack(alignment: .leading) {
                        TextEditor(text: $bio)
                        if bio.isEmpty {
                            VStack {
                                if let userBio = user.bio {
                                    if userBio.isEmpty {
                                        Text("Add bio here...")
                                    } else {
                                        Text("\(userBio)")
                                    }
                                } else {
                                    Text("Add bio here...")
                                }
                            }
                            .foregroundStyle(.gray)
                        }
                    }
                }
                
                Section {
                    Button("Save") {
                        
                        if (!firstName.isEmpty || !lastName.isEmpty || !username.isEmpty || !password.isEmpty || !bio.isEmpty) {
                            
                            if validProfile() {
                                
                                if (!firstName.isEmpty) {
                                    user.firstName = firstName
                                }
                                if (!lastName.isEmpty) {
                                    user.lastName = lastName
                                }
                                if (!username.isEmpty) {
                                    user.username = username
                                }
                                if (!password.isEmpty) {
                                    user.password = password
                                }
                                if (!bio.isEmpty) {
                                    user.bio = bio
                                }
                                
                                do {
                                    try modelContext.save()
                                    dismiss()
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        
                        } else {
                            ()
                        }
                        
                    }
                    .listRowBackground(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                    .foregroundStyle(.black)
                    .bold()
                    .frame(maxWidth: .infinity)   // expands hit area
                    .multilineTextAlignment(.center)
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Ensures profile attributes are valid before saving
    func validProfile() -> Bool {
        
        if (users.contains(where: { $0.username == username }) && username != user.username) {
            errorMessage = "Username already exists. Please choose a different username."
            return false
           
        } else if (users.contains(where: { $0.password == password }) && password != user.password) {
            errorMessage = "Password already exists. Please choose a different password."
            return false
            
        } else {
            return true
        }
    }
}


#Preview {
    
    do {
        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let example = User()
        
        return ProfileView(user: example)
            .modelContainer(container)
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
