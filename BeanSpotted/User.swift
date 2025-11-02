//
//  User.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 11/21/24.
//

//import Foundation
//import SwiftData
//
//@Model
//class User {
//    // Make id unique and immutable (just have to ensure class methods don't change id); UUID provides simpler primary key indexing
//    @Attribute(.unique) private(set) var id = UUID()
//    var name: String
//    var bio: String?
//    var favorites: [CoffeeShop] = []
//    var haveBeen: [CoffeeShop] = []
//    var wantToGo: [CoffeeShop] = []
//    @Relationship(deleteRule: .cascade, inverse: \Review.coffeeShop) var reviews = [Review]()
//    
//    init(name: String = "Lauren Saggar", bio: String? = "I'm a coffee lover and a bean enthusiast. I'm always looking for new places to explore and share my love for coffee.") {
//        self.name = name
//        self.bio = bio
//    }
//}
//
