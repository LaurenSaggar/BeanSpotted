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
    
    // User variables
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var bio = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("User Information") {
                    
                    TextField("\(users.isEmpty ? "First Name" : users[0].firstName)", text: $firstName)
//                    if firstName.isEmpty {
//                        Text("\(users.isEmpty ? "First Name" : users[0].firstName)")
//                            .foregroundStyle(.gray)
//                    }
                    TextField("\(users.isEmpty ? "Last Name" : users[0].lastName)", text: $lastName)
                    
                    TextField("\(users.isEmpty ? "Username" : users[0].username)", text: $username)
                    
                    TextField("\(users.isEmpty ? "Password" : users[0].password)", text: $password)
                    
                    ZStack(alignment: .leading) {
                        TextEditor(text: $bio)
                        if bio.isEmpty {
                            Text("\(users.isEmpty ? "Add bio here" : users[0].bio ?? "Add bio here")")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                
                Section {
                    Button("Save") {
                        
                        if validProfile() {
                            
                            let user = User(firstName: firstName, lastName: lastName, username: username, password: password, bio: bio)
                            
                            if users.isEmpty {
                                modelContext.insert(user)
                            } else {
                                if (!firstName.isEmpty) {
                                    users[0].firstName = user.firstName
                                }
                                if (!lastName.isEmpty) {
                                    users[0].lastName = user.lastName
                                }
                                if (!username.isEmpty) {
                                    users[0].username = user.username
                                }
                                if (!password.isEmpty) {
                                    users[0].password = user.password
                                }
                                if (!bio.isEmpty) {
                                    users[0].bio = user.bio
                                }
                            }

                            do {
                                try modelContext.save()
                                dismiss()
                                print("Users: 1")
                            } catch {
                                print(error.localizedDescription)
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
        if (users.isEmpty) {
            if (firstName.isEmpty || lastName.isEmpty || username.isEmpty || password.isEmpty) {
                return false
            }
        } else {
            ()
        }
        
        return true
    }
}

//private struct ProfilePreviewWrapper: View {
//    
//    @State private var user = User()
//    var body: some View { ProfileView(user: $user) }
//}

#Preview {

//    ProfilePreviewWrapper()
    ProfileView()
    
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    
//    if let container = try? ModelContainer(for: User.self, configurations: config) {
//            ProfileView(user: User()).modelContainer(container)
//        
//        } else {
//            Text("Failed to create preview: \(error.localizedDescription)")
//        }
//    do {
//        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: User.self, configurations: config)
//        let example = User()
//        
//        ProfileView(user: example)
//            .modelContainer(container)
//        
//    } catch {
//        Text("Failed to create preview: \(error.localizedDescription)")
//    }
}
