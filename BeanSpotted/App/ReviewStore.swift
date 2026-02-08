//
//  ReviewStore.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 2/8/26.
//

import Foundation
import SwiftUI

@MainActor
final class ReviewStore: ObservableObject {
    private var cache: [String: ReviewViewModel] = [:]

    // Use existing review model if it already exists in cache or create a new one
    func reviewViewModel(for shopId: String) -> ReviewViewModel {
        
        if let existing = cache[shopId] { return existing }
        
        let vm = ReviewViewModel(shopId: shopId)
        cache[shopId] = vm
        return vm
    }
}
