//
//  BeanSpottedApp.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/14/24.
//

import SwiftData
import SwiftUI

@main
struct BeanSpottedApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        //.modelContainer(for: [CoffeeShop.self, Review.self, User.self])
        .modelContainer(for: [CoffeeShop.self, Review.self, User.self])
    }
}
