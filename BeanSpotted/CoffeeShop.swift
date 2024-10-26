//
//  CoffeeShop.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/14/24.
//

import Foundation
import SwiftData

@Model
class CoffeeShop {
    var name: String
    var address: String
    var openingTime: Date
    var closingTime: Date
    var decafAvailable: Bool
    var local: Bool
    var createTime = Date.now
    var modifyTime = Date.now
    //var reviews = [Review]()
    @Relationship(deleteRule: .cascade, inverse: \Review.coffeeShop) var reviews = [Review]()
    
    init(name: String = "Mom n' Em", address: String = "4310 Whetsel Ave, Cincinnati, OH 45227", openingTime: Date = Date.now, closingTime: Date = Date.now, decafAvailable: Bool = true, local: Bool = true) {
        self.name = name
        self.address = address
        self.openingTime = openingTime
        self.closingTime = closingTime
        self.decafAvailable = decafAvailable
        self.local = local
    }
    
    // Returns average overall rating of all coffee shop reviews
    func averageShopReview() -> Int {
        var totalOverallRating = 0
        var numShopReviews = 0

        for review in reviews {
            totalOverallRating += review.overallRating
            numShopReviews += 1
        }

        if numShopReviews == 0 {
            print("No reviews for this coffee shop name + address")
            return 0
        } else {
            return totalOverallRating / numShopReviews
        }
    }
}
