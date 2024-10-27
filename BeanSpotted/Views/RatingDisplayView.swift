//
//  RatingDisplayView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/24/24.
//

import SwiftUI

struct RatingDisplayView: View {
    
    var rating: Int
    
    var maximumRating = 5
    
    // Positions until rating will always be shown as filled stars
    var image = Image(systemName: "star.fill")
    
    // Positions beyond rating will always be gray
    var offColor = Color.gray
    
    // Positions until rating will always be yellow
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image.foregroundStyle(number > rating ? offColor: onColor)
            }
        }
    }
}

#Preview {
    RatingDisplayView(rating: 4)
}
