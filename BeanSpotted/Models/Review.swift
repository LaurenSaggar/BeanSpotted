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
    var coffeeShop: CoffeeShop?
    var user: User?
    var overallRating: Double = 0
    var coffee: Double
    var nonCoffeeDrinks: Double
    var safety: Double
    var wifiQuality: Double
    var seating: Double
    var quiet: Double
    var parking: Double
    var food: Double
    var value: Double
    var cleanliness: Double
    var staffFriendliness: Double
    var comment: String
    private(set) var createTime = Date.now
    var modifyTime = Date.now
    
    //user: User? = nil,
    init(id: UUID = UUID(), coffeeShop: CoffeeShop? = nil, coffee: Double = 4, nonCoffeeDrinks: Double = 4, safety: Double = 4, wifiQuality: Double = 4, seating: Double = 4, quiet: Double = 4, parking: Double = 4, food: Double = 4, value: Double = 4, cleanliness: Double = 4, staffFriendliness: Double = 4, comment: String = "Incredible!") {
        self.id = id
        self.overallRating = (coffee + nonCoffeeDrinks + safety + wifiQuality + seating + quiet + parking + food + value + cleanliness + staffFriendliness) / 11.0
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
