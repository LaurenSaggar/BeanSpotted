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
    @Relationship(deleteRule: .cascade, inverse: \Review.coffeeShop) var reviews = [Review]()
    //var avgOverallRating = 5
    
    init(name: String = "Mom n' Em", address: String = "4310 Whetsel Ave, Cincinnati, OH 45227", openingTime: Date = Date.now, closingTime: Date = Date.now, decafAvailable: Bool = true, local: Bool = true) {
        self.name = name
        self.address = address
        self.openingTime = openingTime
        self.closingTime = closingTime
        self.decafAvailable = decafAvailable
        self.local = local
    }
    
    // Returns average overall rating of all coffee shop reviews
    func averageOverallRating() -> Int {
        
        // Map reviews array to overall review ratings array
        let ratings = reviews.map( {$0.overallRating} )
        
        if reviews.count > 0 {
            return ratings.reduce(0, +) / reviews.count
        } else {
            print("No reviews for this coffee shop name + address")
            return 0
        }
    }
    
    // Returns average coffee rating of all coffee shop reviews
    func averageCoffeeRating() -> Int {
        
        // Map reviews array to coffee ratings array
        let ratings = reviews.map( {$0.coffee} )
        
        if reviews.count > 0 {
            return ratings.reduce(0, +) / reviews.count
        } else {
            print("No reviews for this coffee shop name + address")
            return 0
        }
    }
    
    // Returns average non-coffee drink rating of all coffee shop reviews
    func averageNonCoffeeDrinkRating() -> Int {
        
        // Map reviews array to non-coffee drink ratings array
        let ratings = reviews.map( {$0.nonCoffeeDrinks} )
        
        if reviews.count > 0 {
            return ratings.reduce(0, +) / reviews.count
        } else {
            print("No reviews for this coffee shop name + address")
            return 0
        }
    }
    
    // Returns average safety rating of all coffee shop reviews
    func averageSafetyRating() -> Int {
        
        // Map reviews array to safety ratings array
        let ratings = reviews.map( {$0.safety} )
        
        if reviews.count > 0 {
            return ratings.reduce(0, +) / reviews.count
        } else {
            print("No reviews for this coffee shop name + address")
            return 0
        }
    }
    
    // Returns average wifi quality rating of all coffee shop reviews
    func averageWifiQualityRating() -> Int {
        
        // Map reviews array to wifi quality ratings array
        let ratings = reviews.map( {$0.wifiQuality} )
        
        if reviews.count > 0 {
            return ratings.reduce(0, +) / reviews.count
        } else {
            print("No reviews for this coffee shop name + address")
            return 0
        }
    }
    
    // Returns average seating rating of all coffee shop reviews
    func averageSeatingRating() -> Int {
        
        // Map reviews array to seating ratings array
        let ratings = reviews.map( {$0.seating} )
        
        if reviews.count > 0 {
            return ratings.reduce(0, +) / reviews.count
        } else {
            print("No reviews for this coffee shop name + address")
            return 0
        }
    }
    
    // Returns average quiet rating of all coffee shop reviews
    func averageQuietRating() -> Int {
        
        // Map reviews array to quiet ratings array
        let ratings = reviews.map( {$0.quiet} )
        
        if reviews.count > 0 {
            return ratings.reduce(0, +) / reviews.count
        } else {
            print("No reviews for this coffee shop name + address")
            return 0
        }
    }
    
    // Returns average parking rating of all coffee shop reviews
    func averageParkingRating() -> Int {
        
        // Map reviews array to parking ratings array
        let ratings = reviews.map( {$0.parking} )
        
        if reviews.count > 0 {
            return ratings.reduce(0, +) / reviews.count
        } else {
            print("No reviews for this coffee shop name + address")
            return 0
        }
    }
    
    // Returns average food rating of all coffee shop reviews
    func averageFoodRating() -> Int {
        
        // Map reviews array to food ratings array
        let ratings = reviews.map( {$0.food} )
        
        if reviews.count > 0 {
            return ratings.reduce(0, +) / reviews.count
        } else {
            print("No reviews for this coffee shop name + address")
            return 0
        }
    }
    
    // Returns average value rating of all coffee shop reviews
    func averageValueRating() -> Int {
        
        // Map reviews array to value ratings array
        let ratings = reviews.map( {$0.value} )
        
        if reviews.count > 0 {
            return ratings.reduce(0, +) / reviews.count
        } else {
            print("No reviews for this coffee shop name + address")
            return 0
        }
    }
    
    // Returns average cleanliness rating of all coffee shop reviews
    func averageCleanlinessRating() -> Int {
        
        // Map reviews array to cleanliness ratings array
        let ratings = reviews.map( {$0.cleanliness} )
        
        if reviews.count > 0 {
            return ratings.reduce(0, +) / reviews.count
        } else {
            print("No reviews for this coffee shop name + address")
            return 0
        }
    }
    
    // Returns average staff friendliness rating of all coffee shop reviews
    func averageStaffFriendlinessRating() -> Int {
        
        // Map reviews array to staff friendliness ratings array
        let ratings = reviews.map( {$0.staffFriendliness} )
        
        if reviews.count > 0 {
            return ratings.reduce(0, +) / reviews.count
        } else {
            print("No reviews for this coffee shop name + address")
            return 0
        }
    }
}
