//
//  ContentView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/14/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @State private var isLoggedIn = false
    @State private var user: User?
    
    var body: some View {
        if isLoggedIn {
            MainTabsView(user: user ?? User())
        } else {
            RootView(isLoggedIn: $isLoggedIn, user: $user)
        }
    }
}

#Preview {
    ContentView()
//    ContentView()
}
