//
//  AuthenticationStartView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 2/1/26.
//

import SwiftUI

enum AuthRoute: Hashable { case login, signup }

struct AuthenticationStartView: View {
    @Binding var isLoggedIn: Bool
    @Binding var user: User?
    @State private var showLoginScreen = false
    @State private var showCreateAccountScreen = false
    @State private var path: [AuthRoute] = []
    
    var body: some View {
        NavigationStack(path: $path) {
                
            VStack {
                
                Spacer()
                
                Text("Bean Spots")
                    .bold()
                    .font(.system(size: 40, weight: .bold, design: .default))
                
                Image("Coffee_Bean_Logo")
                    .resizable()  // Makes the image resizable
                    .aspectRatio(contentMode: .fit)  // Maintains the original aspect ratio
                    .cornerRadius(20)
                    .padding(.bottom)
                
                VStack {
                    Button {
                        //showLoginScreen = true
                        path = [.login]
                    } label: {
                        Text("Log in")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                            .cornerRadius(24)
                    }
                    
                    Button {
                        //showCreateAccountScreen = true
                        path = [.signup]
                    } label: {
                        Text("Create Account")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                            .background(.white)
                            .cornerRadius(24)
                    }
                }
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                        case .login:
                            LoginView(path: $path, isLoggedIn: $isLoggedIn, user: $user)
                                .navigationBarBackButtonHidden()
                        case .signup:
                            CreateAccountView(path: $path, isLoggedIn: $isLoggedIn, user: $user)
                                .navigationBarBackButtonHidden()
                    }
                }
//                .navigationDestination(isPresented: $showLoginScreen) {
//                    LoginView(isLoggedIn: $isLoggedIn, user: $user)
//                        .navigationBarBackButtonHidden()
//                }
//                .navigationDestination(isPresented: $showCreateAccountScreen) {
//                    CreateAccountView(isLoggedIn: $isLoggedIn, user: $user)
//                        .navigationBarBackButtonHidden()
//                }
                .padding(.vertical)
                
                Spacer()
            }
            .padding(35)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AuthenticationStartView(isLoggedIn: .constant(true), user: .constant(User()))
}

