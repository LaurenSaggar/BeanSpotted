//
//  SignUpView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 1/6/26.
//
import SwiftData
import SwiftUI

struct SignUpView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query var users: [User]
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var bio: String = ""
    @State private var signUpValid: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationStack {
            Spacer()
            VStack {
                TextField("First Name", text: $firstName)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)
                
                TextField("Last Name", text: $lastName)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)

                TextField("Password", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)
                
                Button {
                    validSignUp()
                        
                    } label: {
                        Text("Sign Up")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                            .cornerRadius(24)
                    }
                    .navigationDestination(isPresented: $signUpValid) {
                        ContentView()
                    }
                    
                    if !errorMessage.isEmpty {
                        Text("\(errorMessage)")
                    }
            }
            .padding()
            Spacer()
        }
        .preferredColorScheme(.dark)
    }
    
    // Ensures profile attributes are valid before saving
    func validSignUp() {
        if firstName.isEmpty || lastName.isEmpty || username.isEmpty || password.isEmpty {
            errorMessage = "The above fields cannot be empty. Please ensure all fields are entered."
            
        } else if users.contains(where: { $0.username == username }) {
            errorMessage = "Username already exists. Please choose a different username."
           
        } else if users.contains(where: { $0.password == password }) {
            errorMessage = "Password already exists. Please choose a different password."
            
        } else {
            signUpValid = true
            
            let user = User(firstName: firstName, lastName: lastName, username: username, password: password, bio: bio)
            modelContext.insert(user)

            do {
                try modelContext.save()
                dismiss()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

#Preview {
    SignUpView()
}
