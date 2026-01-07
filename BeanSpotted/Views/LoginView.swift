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
                
                Button {
                        
                    } label: {
                        Text("Login")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                            .cornerRadius(24)
                            //.multilineTextAlignment(.center)
                    }
                
//                .listRowBackground(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
//                .foregroundStyle(.black)
//                .bold()
//                .frame(maxWidth: .infinity)   // expands hit area
//                .multilineTextAlignment(.center)
            }
            .padding()
            Spacer()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    LoginView()
}
