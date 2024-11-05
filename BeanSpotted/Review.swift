//
//  Review.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/21/24.
//

import Foundation
import SwiftData

@Model
class Review {
    // Make id unique and immutable (just have to ensure class methods don't change id); UUID provides simpler primary key indexing
    @Attribute(.unique) private(set) var id = UUID()
    var overallRating: Int = 0
    var coffee: Int
    var nonCoffeeDrinks: Int
    var safety: Int
    var wifiQuality: Int
    var seating: Int
    var quiet: Int
    var parking: Int
    var food: Int
    var value: Int
    var cleanliness: Int
    var staffFriendliness: Int
    var comment: String
    private(set) var createTime = Date.now
    var modifyTime = Date.now
    var coffeeShop: CoffeeShop?
    
    init(coffeeShop: CoffeeShop? = nil, coffee: Int = 4, nonCoffeeDrinks: Int = 4, safety: Int = 4, wifiQuality: Int = 4, seating: Int = 4, quiet: Int = 4, parking: Int = 4, food: Int = 4, value: Int = 4, cleanliness: Int = 4, staffFriendliness: Int = 4, comment: String = "Incredible!") {
        self.overallRating = (coffee + nonCoffeeDrinks + safety + wifiQuality + seating + quiet + parking + food + value + cleanliness + staffFriendliness) / 11
        self.coffee = coffee
        self.nonCoffeeDrinks = nonCoffeeDrinks
        self.safety = safety
        self.wifiQuality = wifiQuality
        self.seating = seating
        self.quiet = quiet
        self.parking = parking
        self.food = food
        self.value = value
        self.cleanliness = cleanliness
        self.staffFriendliness = staffFriendliness
        self.comment = comment
    }
}
