//
//  AuthenticationStartView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 2/1/26.

import SwiftUI

enum AuthRoute: Hashable {
    case login
    case signup
}

struct AuthenticationStartView: View {

    @State private var path: [AuthRoute] = []
    
    var body: some View {
        NavigationStack(path: $path) {
                
            VStack {
                
                Spacer()
                
                Text("Bean Spotted")
                    .bold()
                    .font(.system(size: 40, weight: .bold, design: .default))
                
                Image("Coffee_Bean_Logo")
                    .resizable()  // Makes the image resizable
                    .aspectRatio(contentMode: .fit)  // Maintains the original aspect ratio
                    .cornerRadius(20)
                    .padding(.bottom)
                
                VStack {
                    Button {
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
                            LoginView(path: $path)
                                .navigationBarBackButtonHidden()
                        case .signup:
                            CreateAccountView(path: $path)
                                .navigationBarBackButtonHidden()
                    }
                }
                .padding(.vertical)
                
                Spacer()
            }
            .padding(35)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AuthenticationStartView()
}

