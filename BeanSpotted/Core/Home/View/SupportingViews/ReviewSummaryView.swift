//
//  ReviewSummaryView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 2/8/26.
//

import SwiftUI

struct ReviewSummaryView: View {
    
    let shopId: String
    let reviewId: String
    @EnvironmentObject var reviewStore: ReviewStore
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        let reviewViewModel = reviewStore.reviewViewModel(for: shopId)
        let currentReview = reviewViewModel.shopReviews.first(where: { $0.id == reviewId })

        if let review = currentReview {
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Detailed Review")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
                List {
                    Section("Summary") {
                        VStack {
                            
                            Spacer()
                            
                            HStack {
                                Text(review.username)
                                    .bold()
                                Spacer()
                                
                                let startOfDay = Calendar.current.startOfDay(for: review.createTime)
                                
                                if Date.now.timeIntervalSince(startOfDay) < 86400 {
                                    Text("Today at \(formattedTime(review.createTime))")
                                    
                                } else if Date.now.timeIntervalSince(startOfDay) < 172800 {
                                    Text("Yesterday")
                                    
                                } else if Date.now.timeIntervalSince(startOfDay) < 604800 {
                                    Text("Last Week")
                                    
                                } else {
                                    Text("\(formattedDate(review.createTime))")
                                }
                            }
                            
                            Spacer()
                            
                            HStack {
                                RatingDisplayView(rating: Double(review.overallRating))
                                Spacer()
                            }
                            
                            Spacer()
                            
                            HStack {
                                Text(review.comment)
                                Spacer()
                            }
                            
                            Spacer()
                        }
                    }
                    
                    
                    Section("Review Details") {
                        HStack {
                            Text("Overall")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(.white)
                            Spacer()
                            RatingDisplayView(rating: review.overallRating)
                        }
                        .listRowBackground(Color(.sRGB, red: 44/255, green: 145/255, blue: 133/255))
                        
                        HStack {
                            Text("Coffee")
                            Spacer()
                            RatingDisplayView(rating: Double(review.coffeeRating))
                        }
                        
                        HStack {
                            Text("Espresso")
                            Spacer()
                            RatingDisplayView(rating: Double(review.espressoRating))
                        }
                        
                        HStack {
                            Text("Non-Coffee Drinks")
                            Spacer()
                            RatingDisplayView(rating: Double(review.nonCoffeeDrinkRating))
                        }
                        
                        HStack {
                            Text("Safety")
                            Spacer()
                            RatingDisplayView(rating: Double(review.safetyRating))
                        }
                        
                        HStack {
                            Text("WiFi")
                            Spacer()
                            RatingDisplayView(rating: Double(review.wifiRating))
                        }
                        
                        HStack {
                            Text("Seating")
                            Spacer()
                            RatingDisplayView(rating: Double(review.seatingRating))
                        }
                        
                        HStack {
                            Text("Quiet")
                            Spacer()
                            RatingDisplayView(rating: Double(review.quietRating))
                        }
                        
                        HStack {
                            Text("Parking")
                            Spacer()
                            RatingDisplayView(rating: Double(review.parkingRating))
                        }
                        
                        HStack {
                            Text("Food")
                            Spacer()
                            RatingDisplayView(rating: Double(review.foodRating))
                        }
                        
                        HStack {
                            Text("Value")
                            Spacer()
                            RatingDisplayView(rating: Double(review.valueRating))
                        }
                        
                        HStack {
                            Text("Cleanliness")
                            Spacer()
                            RatingDisplayView(rating: Double(review.cleanlinessRating))
                        }
                        
                        HStack {
                            Text("Service")
                            Spacer()
                            RatingDisplayView(rating: Double(review.staffRating))
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button { dismiss() } label: {
                            Image(systemName: "chevron.left")
                                .font(.headline)
                        }
                    }
                }
            }
        }
    }
    
    // Helper function to format date as time only
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // Helper function to format date as date and time
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

//#Preview {
//    ReviewSummaryView()
//}
