//
//  LoginView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 1/6/26.
//
import SwiftData
import SwiftUI

struct LoginView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query var users: [User]
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginValid = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            Spacer()
            VStack {
                TextField("Username", text: $username)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(.secondary)

                TextField("Password", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(.secondary)
                    .padding(.vertical, 4)
                
                VStack {
                    Button {
                        validLogin()
                        
                    } label: {
                        Text("Login")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                            .cornerRadius(24)
                    }
                    .navigationDestination(isPresented: $loginValid) {
                        ContentView()
                    }
                    
                    if !errorMessage.isEmpty {
                        Text("\(errorMessage)")
                    }
                }
            }
            .padding()
            Spacer()
        }
        .preferredColorScheme(.dark)
    }
    
    // Check if login is valid, set state variables, and set appropriate error message if login not valid
    func validLogin() {
        if let index = users.firstIndex(where: { $0.username == username }) {
            if users[index].password == password {
                loginValid = true
            } else {
                errorMessage = "That username + password does not exist."
            }
        } else {
            errorMessage = "That username does not exist."
        }
    }
}

#Preview {
    LoginView()
}
