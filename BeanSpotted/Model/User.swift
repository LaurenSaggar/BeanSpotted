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
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: firstName + " " + lastName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
    var email: String
    var username: String
    var password: String
    var bio: String?
    private(set) var createTime = Date.now
    var modifyTime = Date.now
    var favorites: [CoffeeShop] = []
    var haveBeen: [CoffeeShop] = []
    var wantToGo: [CoffeeShop] = []
    var reviews: [Review] = []
    
    init(id: UUID = UUID(), firstName: String = "Lauren", lastName: String = "Saggar", email: String = "saggar.lauren@gmail.com", username: String = "laurensaggar", password: String = "12345", bio: String? = nil, createTime: Date = Date.now, modifyTime: Date = Date.now) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.username = username
        self.password = password
        self.bio = bio
        self.createTime = createTime
        self.modifyTime = modifyTime
    }
}

