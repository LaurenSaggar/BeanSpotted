//
//  LoginView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 1/6/26.
//
import SwiftData
import SwiftUI

struct LoginView: View {
    
    //@EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query var users: [User]
    
    @Binding var path: [AuthRoute]
    @Binding var isLoggedIn: Bool
    @Binding var user: User?
    
    @State private var showCreateAccountScreen = false
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var userIndex = 0
 
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
                InputView(text: $email,
                          title: "Email Address",
                          placeholder: "name@example.com")
                .autocapitalization(.none)
                
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your password",
                          isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            
            // Sign in button
            Button {
                checkValidLogin()
                //                        Task {
                //                            try await viewModel.signIn(withEmail: email, password: password)
                //                        }
                
            } label: {
                HStack {
                    Text("SIGN IN")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 50, height: 48)
            }
            .background(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
            //                    .disabled(!formIsValid)
            //                    .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(24)
            .padding(.top, 24)
            
            
            if !errorMessage.isEmpty {
                Text("\(errorMessage)")
            }
        }
        .padding()
        
        Spacer()
        
        // Route to sign up
        Button {
            path = [.signup]
        } label: {
            HStack(spacing: 4) {
                Text("Don't have an account?")
                Text("Create Account")
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .font(.system(size: 14))
        }
        .preferredColorScheme(.dark)
    }
    
    // Check if login is valid, set state variables, and set appropriate error message if login not valid
    func checkValidLogin() {
        if let index = users.firstIndex(where: { $0.email == email }) {
            if users[index].password == password {
                userIndex = index
                user = users[userIndex]
                isLoggedIn = true
            } else {
                errorMessage = "That email + password does not exist."
                print("1")
            }
        } else {
            errorMessage = "That username + password does not exist."
            print("2")
            print(users)
        }
    }
}

// MARK: - AuthenticationFormProtocol

//extension LoginView: AuthenticationFormProtocol {
//    var formIsValid: Bool {
//        return !email.isEmpty
//        && email.contains("@")
//        && !password.isEmpty
//        && password.count > 5
//    }
//}

#Preview {
    LoginView(path: .constant([.signup]), isLoggedIn: .constant(true), user: .constant(User()))
}
