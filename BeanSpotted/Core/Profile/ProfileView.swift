//
//  UserView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 11/21/24.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedTab: AppTab
    
    @State private var password = ""
    @State private var showDeleteConfirmationScreen = false
    
    // User variables
//    @State private var firstName: String
//    @State private var lastName: String
//    @State private var email: String
//    @State private var username: String
//    @State private var password: String
//    @State private var bio: String
//    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            if let user = viewModel.currentUser {
                List {
                    Section {
                        HStack {
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 72, height: 72)
                                .background(Color(.systemGray3))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.firstName + " " + user.lastName)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                
                                Text(user.username)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                
//                                Text(user.username)
//                                    .font(.footnote)
//                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    Section("Info") {
                        HStack {
                            SettingsRowView(imageName: "person",
                                            title: "Email:",
                                            tintColor: Color(.systemGray))
                            
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Section("General") {
                        HStack {
                            SettingsRowView(imageName: "gear",
                                            title: "Version:",
                                            tintColor: Color(.systemGray))
                            
                            Text("1.0.0")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Section("Account") {
                        Button {
                            viewModel.signOut()
                        } label: {
                            SettingsRowView(imageName: "arrow.left.circle.fill",
                                            title: "Sign Out",
                                            tintColor: .red)
                        }
                        
                        Button {
                            showDeleteConfirmationScreen.toggle()
                        } label: {
                            SettingsRowView(imageName: "arrow.left.circle.fill",
                                            title: "Delete Account",
                                            tintColor: .red)
                        }
                    }
                }
            }
            
//            Form {
//                Section("User Information") {
//                    
//                    TextField("\(user.firstName)", text: $firstName)
//                    TextField("\(user.lastName)", text: $lastName)
//                    TextField("\(user.email)", text: $email)
//                    TextField("\(user.username)", text: $username)
//                    TextField("\(user.password)", text: $password)
//                    
//                    ZStack(alignment: .leading) {
//                        TextEditor(text: $bio)
//                        if bio.isEmpty {
//                            VStack {
//                                if let userBio = user.bio {
//                                    if userBio.isEmpty {
//                                        Text("Add bio here...")
//                                    } else {
//                                        Text("\(userBio)")
//                                    }
//                                } else {
//                                    Text("Add bio here...")
//                                }
//                            }
//                            .foregroundStyle(.gray)
//                        }
//                    }
//                }
//            }
//            .navigationTitle("\(user.firstName)'s Profile")
//            .padding(.bottom)
//            .frame(maxHeight: 300)
//            
//            Button {
//                
//                if validProfile() {
//                    
//                    user.firstName = firstName
//                    user.lastName = lastName
//                    user.email = email
//                    user.username = username
//                    user.password = password
//                    user.bio = bio
//                    
//                    do {
//                        try modelContext.save()
//                        //profileUpdated = true
//                        selectedTab = .home
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                } else {
//                    ()
//                }
//                
//            } label: {
//                Text("Save")
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .foregroundColor(.white)
//                    .background(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
//                    .cornerRadius(24)
//                    .padding(.horizontal, 45)
//            }
//            
//            if !errorMessage.isEmpty {
//                Text("\(errorMessage)")
//            }
//            
//            Spacer()
        }
        .sheet(isPresented: $showDeleteConfirmationScreen) {
            VStack {
                InputView(text: $password, title: "Password", placeholder: "Enter your password here", isSecureField: true)
                
                Button("Confirm Delete Account") {
                    Task {
                        try await viewModel.deleteAccount(password: password)
                    }
                }
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 70, height: 48)
                .background(.red)
                .cornerRadius(24)
                .padding(.top, 24)
            }
            .padding()
        }
    }
    
    init(selectedTab: Binding<AppTab>) {
//        self.user = user
//        self.firstName = user.firstName
//        self.lastName = user.lastName
//        self.email = user.email
//        self.username = user.username
//        self.password = user.password
//        self.bio = user.bio ?? ""
        self._selectedTab = selectedTab
    }
    
    // Ensures profile attributes are valid before saving
//    func validProfile() -> Bool {
//        
//        if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || username.isEmpty || password.isEmpty) {
//            errorMessage = "All fields (but your bio) must be filled out."
//            return false
//        } else if (users.contains(where: { $0.email == email }) && email != user.email) {
//            errorMessage = "Email already exists. Please choose a different email."
//            return false
//           
//        } else if (users.contains(where: { $0.username == username }) && username != user.username) {
//            errorMessage = "Username already exists. Please choose a different username."
//            return false
//           
//        } else {
//            return true
//        }
//    }
}


#Preview {
    
//    do {
        // In memory ensures entire database doesn't get loaded; must have config and container before making any model object
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: User.self, configurations: config)
//        let example = User()
        
        return ProfileView(selectedTab: .constant(AppTab.profile))
//            .modelContainer(container)
//        
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
}
