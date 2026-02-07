//
//  ReviewViewModel.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 2/2/26.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore


@MainActor
class ReviewViewModel: ObservableObject {
    @Published var shop: CoffeeShop
    @Published var shopReviews: [Review] = []
    
    init(shop: CoffeeShop) {
        self.shop = shop
        Task {
            await fetchAllShopReviews()
        }
    }
    
//    func signIn(withEmail email: String, password: String) async throws {
//        do {
//            let result = try await Auth.auth().signIn(withEmail: email, password: password)
//            self.userSession = result.user
//            await fetchUser()  // use await here to ensure userSession is started before fetchUser() is called
//        } catch {
//            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
//        }
//    }
    
//
    
    func createReview(coffeeRating: Int, espressoRating: Int, nonCoffeeDrinkRating: Int, safetyRating: Int, wifiRating: Int, seatingRating: Int, quietRating: Int, parkingRating: Int, foodRating: Int, valueRating: Int, cleanlinessRating: Int, staffRating: Int, comment: String, createTime: Date, modifyTime: Date) async throws {
        
        // Get current user
        guard let uid = Auth.auth().currentUser?.uid else {return}  // get authenticated user
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}  // get firebase store user
        let user = try? snapshot.data(as: User.self)  // Set firebase user to current app user for app activity
        
        // Create new review locally
        let review = Review(id: NSUUID().uuidString, coffeeRating: coffeeRating, espressoRating: espressoRating, nonCoffeeDrinkRating: nonCoffeeDrinkRating, safetyRating: safetyRating, wifiRating: wifiRating, seatingRating: seatingRating, quietRating: quietRating, parkingRating: parkingRating, foodRating: foodRating, valueRating: valueRating, cleanlinessRating: cleanlinessRating, staffRating: staffRating, comment: comment, shopId: shop.id, shopName: shop.name, userId: uid, username: user?.username ?? "Unknown User")
        
        do {
            // Send new review to firebase
            let encodedReview = try Firestore.Encoder().encode(review)  // Encode review in JSON for upload to firebase
            try await Firestore.firestore().collection("coffeeShops").document(shop.id).collection("reviews").document(review.id).setData(encodedReview)
            
            // Get necessary firebase references for shop update
            let shopRef = Firestore.firestore().collection("coffeeShops").document(shop.id)
            let reviewRef = shopRef.collection("reviews").document(review.id)
            
            do {
                // Update shop info
                var updates: [String: Any] = [
                    // Update rating sum variables
                    "overallRatingSum": FieldValue.increment(Int64(review.overallRating)),
                    "coffeeRatingSum": FieldValue.increment(Int64(coffeeRating)),
                    "espressoRatingSum": FieldValue.increment(Int64(espressoRating)),
                    "nonCoffeeDrinkRatingSum": FieldValue.increment(Int64(nonCoffeeDrinkRating)),
                    "safetyRatingSum": FieldValue.increment(Int64(nonCoffeeDrinkRating)),
                    "wifiRatingSum": FieldValue.increment(Int64(wifiRating)),
                    "seatingRatingSum": FieldValue.increment(Int64(seatingRating)),
                    "quietRatingSum": FieldValue.increment(Int64(quietRating)),
                    "parkingRatingSum": FieldValue.increment(Int64(parkingRating)),
                    "foodRatingSum": FieldValue.increment(Int64(foodRating)),
                    "valueRatingSum": FieldValue.increment(Int64(valueRating)),
                    "cleanlinessRatingSum": FieldValue.increment(Int64(cleanlinessRating)),
                    "staffRatingSum": FieldValue.increment(Int64(staffRating)),
                    "reviewCount": FieldValue.increment(Int64(1)),
                    
                    // Update modify time
                    "modifyTime": FieldValue.serverTimestamp()
                ]
                
                
                // Update rating count variables
                
                if review.overallRating > 0 { updates["overallRatingCount"] = FieldValue.increment(Int64(1)) }
                if coffeeRating > 0 { updates["coffeeRatingCount"] = FieldValue.increment(Int64(1)) }
                if espressoRating > 0 { updates["espressoRatingCount"] = FieldValue.increment(Int64(1)) }
                if nonCoffeeDrinkRating > 0 { updates["nonCoffeeDrinkRatingCount"] = FieldValue.increment(Int64(1)) }
                if safetyRating > 0 { updates["safetyRatingCount"] = FieldValue.increment(Int64(1)) }
                if wifiRating > 0 { updates["wifiRatingCount"] = FieldValue.increment(Int64(1)) }
                if seatingRating > 0 { updates["seatingRatingCount"] = FieldValue.increment(Int64(1)) }
                if quietRating > 0 { updates["quietRatingCount"] = FieldValue.increment(Int64(1)) }
                if parkingRating > 0 { updates["parkingRatingCount"] = FieldValue.increment(Int64(1)) }
                if foodRating > 0 { updates["foodRatingCount"] = FieldValue.increment(Int64(1)) }
                if valueRating > 0 { updates["valueRatingCount"] = FieldValue.increment(Int64(1)) }
                if cleanlinessRating > 0 { updates["cleanlinessRatingCount"] = FieldValue.increment(Int64(1)) }
                if staffRating > 0 { updates["staffRatingCount"] = FieldValue.increment(Int64(1)) }
                
                try await shopRef.updateData(updates)
                
                await fetchAllShopReviews()
                
            } catch {
                try? await reviewRef.delete()
                print("DEBUG: Failed to update shop with new review info with error: \(error.localizedDescription)")
            }
            
        } catch {
            print("DEBUG: Failed to create review with error \(error.localizedDescription)")
        }
    }
    

    func fetchAllShopReviews() async {
        guard let snapshot = try? await Firestore.firestore().collection("coffeeShops").document(shop.id).collection("reviews").order(by: "createTime", descending: true).getDocuments() else { return }
        self.shopReviews = snapshot.documents.compactMap { doc in
            try? doc.data(as: Review.self)
        }
    }
}

