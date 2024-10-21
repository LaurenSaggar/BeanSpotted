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
    var openingHour: Date
    var closingHour: Date
    var decafAvailable: Bool
    var local: Bool
    
    init(name: String, address: String, openingHour: Date, closingHour: Date, decafAvailable: Bool, local: Bool) {
        self.name = name
        self.address = address
        self.openingHour = openingHour
        self.closingHour = closingHour
        self.decafAvailable = decafAvailable
        self.local = local
    }
}
