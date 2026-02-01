//
//  HomeView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 1/7/26.
//

import SwiftUI

struct RootView: View {
    
    @Binding var isLoggedIn: Bool
    @Binding var user: User?
    @State private var showLoginScreen = false
    @State private var showCreateAccountScreen = false
    
    var body: some View {
        NavigationStack {
                
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
                        showLoginScreen = true
                    } label: {
                        Text("Login")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                            .cornerRadius(24)
                    }
                    .navigationDestination(isPresented: $showLoginScreen) {
                        LoginView(isLoggedIn: $isLoggedIn, user: $user)
                    }
                    
                    Button {
                        showCreateAccountScreen = true
                    } label: {
                        Text("Create Account")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                            .background(.white)
                            .cornerRadius(24)
                    }
                    .navigationDestination(isPresented: $showCreateAccountScreen) {
                        CreateAccountView(isLoggedIn: $isLoggedIn, user: $user)
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
    RootView(isLoggedIn: .constant(true), user: .constant(User()))
}
