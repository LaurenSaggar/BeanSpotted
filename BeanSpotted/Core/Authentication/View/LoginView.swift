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
    
    @Binding var isLoggedIn: Bool
    @Binding var user: User?
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage = ""
    @State private var userIndex = 0
 
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
                        checkValidLogin()
                        
                    } label: {
                        Text("Login")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                            .cornerRadius(24)
                            .padding(.horizontal)
                    }
                    
                    if !errorMessage.isEmpty {
                        Text("\(errorMessage)")
                    }
                }
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Login")
        .preferredColorScheme(.dark)
    }
    
    // Check if login is valid, set state variables, and set appropriate error message if login not valid
    func checkValidLogin() {
        if let index = users.firstIndex(where: { $0.username == username }) {
            if users[index].password == password {
                userIndex = index
                user = users[userIndex]
                isLoggedIn = true
            } else {
                errorMessage = "That username + password does not exist."
            }
        } else {
            errorMessage = "That username does not exist."
        }
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(true), user: .constant(User()))
}
