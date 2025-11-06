//
//  User.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 11/3/25.
//

import Foundation
import SwiftData

@Model
class User {
    // Make id unique and immutable (just have to ensure class methods don't change id); UUID provides simpler primary key indexing
    @Attribute(.unique) private(set) var id = UUID()
    var firstName: String
    var lastName: String
    var bio: String?
    private(set) var createTime = Date.now
    var modifyTime = Date.now
    @Relationship(deleteRule: .cascade, inverse: \Review.user)
    var reviews = [Review]()
    var haveBeen = [CoffeeShop]()
    var wantToGo = [CoffeeShop]()
    var favorites = [CoffeeShop]()
    
    init(id: UUID = UUID(), firstName: String = "Lauren", lastName: String = "Saggar", bio: String? = nil, createTime: Foundation.Date = Date.now, modifyTime: Foundation.Date = Date.now) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.bio = bio
        self.createTime = createTime
        self.modifyTime = modifyTime
    }
}

