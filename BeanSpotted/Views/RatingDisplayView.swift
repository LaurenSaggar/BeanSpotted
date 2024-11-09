//
//  RatingDisplayView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/24/24.
//

import SwiftUI

struct RatingDisplayView: View {
    
    var rating: Double
    
    var maximumRating = 5
    
    // Positions until rating will always be shown as filled stars
    var fullStar = Image(systemName: "star.fill")
    
    // Positions until rating will always be shown as half stars
    var halfStar = Image(systemName: "star.leadinghalf.fill")
    
    // Positions beyond rating will always be gray
    var offColor = Color.gray
    
    // Positions until rating will always be yellow
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            
            // Filled in all full stars
            ForEach(1..<Int(rating.rounded(.down)) + 1, id: \.self) { number in
                fullStar.foregroundStyle(onColor)
            }
            
            // Fill in potential half star
            if (Int(rating.rounded(.down)) + 1 < maximumRating + 1) {
                if (rating - rating.rounded(.down) >= 0.75) {
                    fullStar.foregroundStyle(onColor)
                    
                } else if (rating - rating.rounded(.down) >= 0.25) {
                    halfStar.foregroundStyle(onColor)
                    
                } else {
                    fullStar.foregroundStyle(offColor)
                }
            }
            
            // Fill in empty stars
            if (Int(rating.rounded(.down)) + 2 < maximumRating + 1) {
                ForEach(Int(rating.rounded(.down)) + 2..<maximumRating + 1, id: \.self) { number in
                    fullStar.foregroundStyle(offColor)
                }
            }
        }
    }
}

#Preview {
    RatingDisplayView(rating: 4.0)
}
