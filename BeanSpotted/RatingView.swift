//
//  RatingView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/23/24.
//

import SwiftUI

struct RatingView: View {
    // Binding to rating allows us to share this variable declared in another view (and change that variable here as needed)
    @Binding var rating: Int
    
    // Could choose to add text before the rating visual
    var label = ""
    var maximumRating = 5
    
    // Optionally add an image for positions beyond rating
    var offImage: Image?
    // Positions until rating will always be shown as filled stars
    var onImage = Image(systemName: "star.fill")
    
    // Positions beyond rating will always be gray
    var offColor = Color.gray
    // Positions until rating will always be yellow
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                // Creates 5 star buttons
                Button {
                    rating = number
                // Reinvoked each time button is pressed
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor: onColor)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    // Determines the image shown for each potential rating position
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
    // RatingView(rating: .constant(4), offImage: Image(systemName: "circle"))
}
