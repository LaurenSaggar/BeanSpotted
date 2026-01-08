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
                    //.padding(.bottom, 100)
                
                Spacer()
                
                
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
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                            .background(.white)
                            .cornerRadius(24)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    HomeView()
}
