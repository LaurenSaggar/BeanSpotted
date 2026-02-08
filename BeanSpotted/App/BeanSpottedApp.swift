//
//  BeanSpottedApp.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/14/24.
//

import SwiftData
import SwiftUI
import Firebase

@main
struct BeanSpottedApp: App {
    @StateObject var viewModel = AuthViewModel()
    @StateObject private var reviewStore = ReviewStore()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(viewModel)
        .environmentObject(reviewStore)
        //.modelContainer(for: [CoffeeShop.self, Review.self, User.self])
//        .modelContainer(for: [CoffeeShop.self, Review.self, User.self])
    }
}
