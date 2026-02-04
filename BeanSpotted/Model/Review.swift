//
//  Review.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/21/24.
//

import Foundation

struct Review: Identifiable, Codable {
    var id: String
    var overallRating: Int
    var coffeeRating: Int
    var espressoRating: Int
    var nonCoffeeDrinkRating: Int
    var safetyRating: Int
    var wifiRating: Int
    var seatingRating: Int
    var quietRating: Int
    var parkingRating: Int
    var foodRating: Int
    var valueRating: Int
    var cleanlinessRating: Int
    var staffRating: Int
    var comment: String
    private(set) var createTime = Date.now
    var modifyTime = Date.now
    var shopId: String
    var shopName: String
    var userId: String
    var username: String
}

extension Review {
    static var MOCK_REVIEW = Review(id: NSUUID().uuidString, overallRating: 4, coffeeRating: 4, espressoRating: 4, nonCoffeeDrinkRating: 4, safetyRating: 4, wifiRating: 4, seatingRating: 4, quietRating: 4, parkingRating: 4, foodRating: 4, valueRating: 4, cleanlinessRating: 4, staffRating: 4, comment: "Amazing espresso!", createTime: Date.now, modifyTime: Date.now, shopId: NSUUID().uuidString, shopName: "", userId: NSUUID().uuidString, username: "")
}
