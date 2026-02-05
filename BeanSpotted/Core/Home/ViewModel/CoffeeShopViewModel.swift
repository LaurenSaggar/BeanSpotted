//
//  CoffeeShopViewModel.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 2/2/26.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore


@MainActor
class CoffeeShopViewModel: ObservableObject {
    @Published var shops: [CoffeeShop] = []
    
    init() {
        Task {
            await fetchAllShops()
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
    func createShop(name: String, address: String, city: String, state: String, openingTime: Date, closingTime: Date, decafAvailable: Bool, local: Bool) async throws {
        do {
            let shop = CoffeeShop(id: NSUUID().uuidString, name: name, address: address, city: city, state: state, openingTime: openingTime, closingTime: closingTime, decafAvailable: decafAvailable, local: local, createTime: Date.now, modifyTime: Date.now, overallRatingSum: 0, coffeeRatingSum: 0, espressoRatingSum: 0, nonCoffeeDrinkRatingSum: 0, safetyRatingSum: 0, wifiRatingSum: 0, seatingRatingSum: 0, quietRatingSum: 0, parkingRatingSum: 0, foodRatingSum: 0, valueRatingSum: 0, cleanlinessRatingSum: 0, staffRatingSum: 0, overallRatingCount: 0, coffeeRatingCount: 0, espressoRatingCount: 0, nonCoffeeDrinkRatingCount: 0, safetyRatingCount: 0, wifiRatingCount: 0, seatingRatingCount: 0, quietRatingCount: 0, parkingRatingCount: 0, foodRatingCount: 0, valueRatingCount: 0, cleanlinessRatingCount: 0, staffRatingCount: 0)
            let encodedShop = try Firestore.Encoder().encode(shop)  // Encode shop in JSON for upload to firebase
            try await Firestore.firestore().collection("coffeeShops").document(shop.id).setData(encodedShop)
            await fetchAllShops()
            
        } catch {
            print("DEBUG: Failed to create coffee shop with error \(error.localizedDescription)")
        }
    }

//    func updateUserFields() {
//        
//    }
//    
//    func signOut() {
//        do {
//            try Auth.auth().signOut()  // signs out user on backend
//            self.userSession = nil  // wipes out user session and takes us back to login screen
//            self.currentUser = nil  // wipes out current user data model
//        } catch {
//            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
//        }
//    }
//    
//    func deleteAccount(password: String) async throws {
//        guard let user = Auth.auth().currentUser else { return }
//        guard let email = user.email else { return }
//
//        let cred = EmailAuthProvider.credential(withEmail: email, password: password)
//        
//        do {
//            try await user.reauthenticate(with: cred)
//            do {
//                try await Firestore.firestore().collection("users").document(user.uid).delete()
//                do {
//                    try await user.delete()
//                    self.userSession = nil  // wipes out user session and takes us back to login screen
//                    self.currentUser = nil  // wipes out current user data model
//                } catch {
//                    print("DEBUG: Authentication delete error: \(error.localizedDescription)")
//                }
//            } catch {
//                print("DEBUG: Firestore delete error: \(error.localizedDescription)")
//            }
//        } catch {
//            print("DEBUG: Reauthentication error: \(error.localizedDescription)")
//        }
//    }
//    
    
    func fetchAllShops() async {
        guard let snapshot = try? await Firestore.firestore().collection("coffeeShops").getDocuments() else { return }
        self.shops = snapshot.documents.compactMap { doc in
            try? doc.data(as: CoffeeShop.self)
        }
    }
}

