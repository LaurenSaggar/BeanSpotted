//
//  HomeView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 1/7/26.
//

import SwiftUI

struct HomeView: View {
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
                    //.padding()
                    //.frame(width: 200, height: 200) // Sets a specific size for the image view
                
                VStack {
                    Button {
                    } label: {
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                                .cornerRadius(24)
                        }
                    }
                    
                    Button {
                    } label: {
                        NavigationLink(destination: CreateAccountView()) {
                            Text("Create Account")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                                .background(.white)
                                .cornerRadius(24)
                        }
                    }
                }
                .padding(.vertical)
                
                Spacer()
            }
            .padding(35)
            //.padding()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    HomeView()
}
