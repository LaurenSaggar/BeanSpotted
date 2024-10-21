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
    var coffeeShopName: String
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
    
    init(coffeeShopName: String, coffee: Int, nonCoffeeDrinks: Int, safety: Int, wifiQuality: Int, seating: Int, quiet: Int, parking: Int, food: Int, value: Int, cleanliness: Int, staffFriendliness: Int) {
        self.coffeeShopName = coffeeShopName
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
    }
}
