//
//  User.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 11/3/25.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
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
    var bio: String
    private(set) var createTime = Date.now
    var modifyTime = Date.now
//    var favorites: [CoffeeShop] = []
//    var haveBeen: [CoffeeShop] = []
//    var wantToGo: [CoffeeShop] = []
//    var reviews: [Review] = []
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, firstName: "Alicia", lastName: "Keys", email: "aliciakeys@gmail.com", username: "aliciakeys", bio: "", createTime: Date.now, modifyTime: Date.now)
}

