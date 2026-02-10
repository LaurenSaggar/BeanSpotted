//
//  ContentView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/14/24.

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if viewModel.userSession != nil {
            MainTabsView()
                .preferredColorScheme(.dark)
        } else {
            AuthenticationStartView()
                .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
