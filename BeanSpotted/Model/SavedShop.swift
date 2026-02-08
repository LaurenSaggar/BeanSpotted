//
//  SavedShop.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 2/7/26.
//

import Foundation

struct SavedShop: Identifiable, Codable {
    var id: String
    var name: String
    var city: String
    var state: String
    var isFavorite: Bool = false
    var isWantToGo: Bool = false
    var isHaveBeen: Bool = false
    var updateTime = Date.now
}

extension SavedShop {
    static var MOCK_SAVED_SHOP = SavedShop(id: NSUUID().uuidString, name: "Mom n' Em", city: "Cincinnati", state: "OH", isFavorite: false, isWantToGo: false, isHaveBeen: false, updateTime: Date.now)
}
