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
    
    init(name: String, address: String, openingTime: Date, closingTime: Date, decafAvailable: Bool, local: Bool) {
        self.name = name
        self.address = address
        self.openingTime = openingTime
        self.closingTime = closingTime
        self.decafAvailable = decafAvailable
        self.local = local
    }
}
