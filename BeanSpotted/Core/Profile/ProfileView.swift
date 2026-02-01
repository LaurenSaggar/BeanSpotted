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
    
    @Query var users: [User]
    let user: User
    
    @Binding var selectedTab: AppTab
    
    // User variables
    @State private var firstName: String
    @State private var lastName: String
    @State private var email: String
    @State private var username: String
    @State private var password: String
    @State private var bio: String
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("User Information") {
                    
                    TextField("\(user.firstName)", text: $firstName)
                    TextField("\(user.lastName)", text: $lastName)
                    TextField("\(user.email)", text: $email)
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
            }
            .navigationTitle("\(user.firstName)'s Profile")
            .padding(.bottom)
            .frame(maxHeight: 300)
            
            Button {
                
                if validProfile() {
                    
                    user.firstName = firstName
                    user.lastName = lastName
                    user.email = email
                    user.username = username
                    user.password = password
                    user.bio = bio
                    
                    do {
                        try modelContext.save()
                        //profileUpdated = true
                        selectedTab = .home
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    ()
                }
                
            } label: {
                Text("Save")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                    .cornerRadius(24)
                    .padding(.horizontal, 45)
            }
            
            if !errorMessage.isEmpty {
                Text("\(errorMessage)")
            }
            
            Spacer()
        }
    }
    
    init(user: User, selectedTab: Binding<AppTab>) {
        self.user = user
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.email = user.email
        self.username = user.username
        self.password = user.password
        self.bio = user.bio ?? ""
        self._selectedTab = selectedTab
    }
    
    // Ensures profile attributes are valid before saving
    func validProfile() -> Bool {
        
        if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || username.isEmpty || password.isEmpty) {
            errorMessage = "All fields (but your bio) must be filled out."
            return false
        } else if (users.contains(where: { $0.email == email }) && email != user.email) {
            errorMessage = "Email already exists. Please choose a different email."
            return false
           
        } else if (users.contains(where: { $0.username == username }) && username != user.username) {
            errorMessage = "Username already exists. Please choose a different username."
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
        
        return ProfileView(user: example, selectedTab: .constant(AppTab.profile))
            .modelContainer(container)
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
