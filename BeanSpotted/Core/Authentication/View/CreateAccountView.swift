//
//  SignUpView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 1/6/26.

import SwiftUI

struct CreateAccountView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @Binding var path: [AuthRoute]
    
    @State private var showLoginScreen = false
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var bio: String = ""
    
    var body: some View {
        VStack {
            // Image
            Image("Coffee_Bean_Logo")
                .resizable()
                .scaledToFill()
                .cornerRadius(20)
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            // Form fields
            VStack(spacing: 24) {
                InputView(text: $firstName,
                          title: "First Name",
                          placeholder: "Enter your first name")
                
                InputView(text: $lastName,
                          title: "Last Name",
                          placeholder: "Enter your last name")
                
                InputView(text: $email,
                          title: "Email",
                          placeholder: "mr.bean@gmail.com")
                .autocapitalization(.none)
                
                InputView(text: $username,
                          title: "Username",
                          placeholder: "Enter your username")
                .autocapitalization(.none)
                
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your password",
                          isSecureField: true)
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Confirm your password",
                              isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await viewModel.createUser(firstName: firstName,
                                                   lastName: lastName,
                                                   withEmail: email,
                                                   username: username,
                                                   password: password)
                }
                
            } label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 50, height: 48)
            }
            .background(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(24)
            .padding(.top, 24)
            
            Spacer()
            
            // Route to login
            Button {
                path = [.login]
            } label: {
                HStack(spacing: 4) {
                    Text("Already have an account?")
                    Text("Log in")
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .font(.system(size: 14))
            }
        }
        .preferredColorScheme(.dark)
    }
}


// MARK: - AuthenticationFormProtocol

extension CreateAccountView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !firstName.isEmpty
        && !lastName.isEmpty
        && !email.isEmpty
        && !username.isEmpty
        && !password.isEmpty
        && email.contains("@")
        && password.count > 5
        && confirmPassword == password
    }
}


#Preview {
    CreateAccountView(path: Binding.constant([.signup]))
}
