//
//  CoffeeShop.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/14/24.
//

import Foundation

struct CoffeeShop: Identifiable, Codable {
    var id: String
    var name: String
    var address: String
//    var nameandaddress: String {
//        return name + " " + address
//    }
    var city: String
    var state: String
    var openingTime: Date
    var closingTime: Date
    var decafAvailable: Bool
    var local: Bool
    private(set) var createTime = Date.now
    var modifyTime = Date.now
    
    // Rating sum variables
    var overallRatingSum: Int
    var coffeeRatingSum: Int
    var espressoRatingSum: Int
    var nonCoffeeDrinkRatingSum: Int
    var safetyRatingSum: Int
    var wifiRatingSum: Int
    var seatingRatingSum: Int
    var quietRatingSum: Int
    var parkingRatingSum: Int
    var foodRatingSum: Int
    var valueRatingSum: Int
    var cleanlinessRatingSum: Int
    var staffRatingSum: Int
    
    // Rating count variables
    var reviewCount: Int = 0
    var overallRatingCount: Int
    var coffeeRatingCount: Int
    var espressoRatingCount: Int
    var nonCoffeeDrinkRatingCount: Int
    var safetyRatingCount: Int
    var wifiRatingCount: Int
    var seatingRatingCount: Int
    var quietRatingCount: Int
    var parkingRatingCount: Int
    var foodRatingCount: Int
    var valueRatingCount: Int
    var cleanlinessRatingCount: Int
    var staffRatingCount: Int
    
    // Average rating variables
    var avgOverallRating: Double {
        guard overallRatingCount > 0 else { return 0 }
        return Double(overallRatingSum) / Double(overallRatingCount)
    }
    
    var avgCoffeeRating: Double {
        guard coffeeRatingCount > 0 else { return 0 }
        return Double(coffeeRatingSum) / Double(coffeeRatingCount)
    }
    
    var avgEspressoRating: Double {
        guard espressoRatingCount > 0 else { return 0 }
        return Double(espressoRatingSum) / Double(espressoRatingCount)
    }
    
    var avgNonCoffeeDrinkRating: Double {
        guard nonCoffeeDrinkRatingCount > 0 else { return 0 }
        return Double(nonCoffeeDrinkRatingSum) / Double(nonCoffeeDrinkRatingCount)
    }
    
    var avgSafetyRating: Double {
        guard safetyRatingCount > 0 else { return 0 }
        return Double(safetyRatingSum) / Double(safetyRatingCount)
    }
    
    var avgWifiRating: Double {
        guard wifiRatingCount > 0 else { return 0 }
        return Double(wifiRatingSum) / Double(wifiRatingCount)
    }
    
    var avgSeatingRating: Double {
        guard seatingRatingCount > 0 else { return 0 }
        return Double(seatingRatingSum) / Double(seatingRatingCount)
    }
    
    var avgQuietRating: Double {
        guard quietRatingCount > 0 else { return 0 }
        return Double(quietRatingSum) / Double(quietRatingCount)
    }
    
    var avgParkingRating: Double {
        guard parkingRatingCount > 0 else { return 0 }
        return Double(parkingRatingSum) / Double(parkingRatingCount)
    }
    
    var avgFoodRating: Double {
        guard foodRatingCount > 0 else { return 0 }
        return Double(foodRatingSum) / Double(foodRatingCount)
    }
    
    var avgValueRating: Double {
        guard valueRatingCount > 0 else { return 0 }
        return Double(valueRatingSum) / Double(valueRatingCount)
    }
    
    var avgCleanlinessRating: Double {
        guard cleanlinessRatingCount > 0 else { return 0 }
        return Double(cleanlinessRatingSum) / Double(cleanlinessRatingCount)
    }
    
    var avgStaffRating: Double {
        guard staffRatingCount > 0 else { return 0 }
        return Double(staffRatingSum) / Double(staffRatingCount)
    }
    
    //@Relationship(deleteRule: .cascade, inverse: \Review.coffeeShop)
    //var reviews: [Review] = []
}

extension CoffeeShop {
    static var MOCK_SHOP = CoffeeShop(id: NSUUID().uuidString, name: "Mom n' Em", address: "4310 Whetsel Ave, Cincinnati, OH 45227", city: "Cincinnati", state: "OH", openingTime: Date.now, closingTime: Date.now, decafAvailable: true, local: true, createTime: Date.now, modifyTime: Date.now, overallRatingSum: 0, coffeeRatingSum: 0, espressoRatingSum: 0, nonCoffeeDrinkRatingSum: 0, safetyRatingSum: 0, wifiRatingSum: 0, seatingRatingSum: 0, quietRatingSum: 0, parkingRatingSum: 0, foodRatingSum: 0, valueRatingSum: 0, cleanlinessRatingSum: 0, staffRatingSum: 0, overallRatingCount: 0, coffeeRatingCount: 0, espressoRatingCount: 0, nonCoffeeDrinkRatingCount: 0, safetyRatingCount: 0, wifiRatingCount: 0, seatingRatingCount: 0, quietRatingCount: 0, parkingRatingCount: 0, foodRatingCount: 0, valueRatingCount: 0, cleanlinessRatingCount: 0, staffRatingCount: 0)
}
