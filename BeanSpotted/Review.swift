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
    //var coffeeShopName: String
    //var coffeeShopAddress: String
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
    var overallRating = 0
    var comment: String
    var createTime = Date.now
    var modifyTime = Date.now
    var coffeeShop: CoffeeShop?
    
    init(coffeeShop: CoffeeShop? = nil, coffee: Int = 4, nonCoffeeDrinks: Int = 4, safety: Int = 4, wifiQuality: Int = 4, seating: Int = 4, quiet: Int = 4, parking: Int = 4, food: Int = 4, value: Int = 4, cleanliness: Int = 4, staffFriendliness: Int = 4, comment: String = "Incredible!") {
        //self.coffeeShopName = coffeeShopName
        //self.coffeeShopAddress = coffeeShopAddress
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
        self.overallRating = (coffee + nonCoffeeDrinks + safety + wifiQuality + seating + quiet + parking + food + value + cleanliness + staffFriendliness) / 11
        self.staffFriendliness = staffFriendliness
        self.comment = comment
    }
    
    // Returns average overall rating of all coffee shop reviews
//    func averageShopReview(reviews: [Review], shopName: String, shopAddress: String) -> Int {
//        var totalOverallRating = 0
//        var numShopReviews = 0
//        
//        for review in reviews {
//            if (review.coffeeShopName == shopName && review.coffeeShopAddress == shopAddress) {
//                totalOverallRating += review.overallRating
//                numShopReviews += 1
//            }
//        }
//        
//        if numShopReviews == 0 {
//            print("No reviews for this coffee shop name + address")
//            return 0
//        } else {
//            return totalOverallRating / numShopReviews
//        }
//    }
}
