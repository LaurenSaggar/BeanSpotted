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
    var title: String
    var openingHour: Date
    var closingHour: Date
    var review: String
    
    init(title: String, openingHour: Date, closingHour: Date, review: String) {
        self.title = title
        self.openingHour = openingHour
        self.closingHour = closingHour
        self.review = review
    }
}
