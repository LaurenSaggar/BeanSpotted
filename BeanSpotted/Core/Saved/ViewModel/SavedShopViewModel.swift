//
//  SavedShopsViewModel.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 2/7/26.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore


@MainActor
class SavedShopViewModel: ObservableObject {
    @Published var favorites: [SavedShop] = []
    @Published var wantToGo: [SavedShop] = []
    @Published var haveBeen: [SavedShop] = []
    
    init() {
        Task {
            await fetchAllFavorites()
            await fetchAllWantToGo()
            await fetchAllHaveBeen()
        }
    }
    
    func addToFavorites(shop: CoffeeShop) async throws {
    
        // Get current user
        guard let uid = Auth.auth().currentUser?.uid else {return}  // get authenticated user
        //guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}  // get firebase store user
        //let user = try? snapshot.data(as: User.self)  // Set firebase user to current app user for app activity
        
        let savedShopRef = Firestore.firestore().collection("users").document(uid).collection("savedShops").document(shop.id)
        
        do {
            try await savedShopRef.setData([
                "id": shop.id,
                "name": shop.name,
                "city": shop.city,
                "state": shop.state,
                "isFavorite": true,
                "isWantToGo": wantToGo.contains(where: { $0.id == shop.id }),
                "isHaveBeen": haveBeen.contains(where: { $0.id == shop.id }),
                "updateTime": FieldValue.serverTimestamp()
            ], merge: true)
            
            await fetchAllFavorites()
            
        } catch {
            print("DEBUG: Failed to add shop to \"Favorites\" with error: \(error.localizedDescription)")
        }
    }
    
    
    func addToWantToGo(shop: CoffeeShop) async throws {
    
        // Get current user
        guard let uid = Auth.auth().currentUser?.uid else {return}  // get authenticated user
        //guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}  // get firebase store user
        //let user = try? snapshot.data(as: User.self)  // Set firebase user to current app user for app activity
        
        let savedShopRef = Firestore.firestore().collection("users").document(uid).collection("savedShops").document(shop.id)
        
        do {
            try await savedShopRef.setData([
                "id": shop.id,
                "name": shop.name,
                "city": shop.city,
                "state": shop.state,
                "isFavorite": favorites.contains(where: { $0.id == shop.id }),
                "isWantToGo": true,
                "isHaveBeen": haveBeen.contains(where: { $0.id == shop.id }),
                "updateTime": FieldValue.serverTimestamp()
            ], merge: true)
            
            await fetchAllWantToGo()
            
        } catch {
            print("DEBUG: Failed to add shop to \"Want To Go\" with error: \(error.localizedDescription)")
        }
    }
    
    
    func addToHaveBeen(shop: CoffeeShop) async throws {
    
        // Get current user
        guard let uid = Auth.auth().currentUser?.uid else {return}  // get authenticated user
        //guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}  // get firebase store user
        //let user = try? snapshot.data(as: User.self)  // Set firebase user to current app user for app activity
        
        let savedShopRef = Firestore.firestore().collection("users").document(uid).collection("savedShops").document(shop.id)
        
        do {
            try await savedShopRef.setData([
                "id": shop.id,
                "name": shop.name,
                "city": shop.city,
                "state": shop.state,
                "isFavorite": favorites.contains(where: { $0.id == shop.id }),
                "isWantToGo": wantToGo.contains(where: { $0.id == shop.id }),
                "isHaveBeen": true,
                "updateTime": FieldValue.serverTimestamp()
            ], merge: true)
            
            await fetchAllHaveBeen()
            
        } catch {
            print("DEBUG: Failed to add shop to \"Have Been\" with error: \(error.localizedDescription)")
        }
    }
    
    
    func removeFromFavorites(shop: CoffeeShop) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}  // get authenticated user
        
        let ref = Firestore.firestore().collection("users").document(uid).collection("savedShops").document(shop.id)
        let snapshot = try await ref.getDocument()
        let data = snapshot.data() ?? [:]
        
        let isWantToGo = data["isWantToGo"] as? Bool ?? false
        let isHaveBeen = data["isHaveBeen"] as? Bool ?? false

        do {
            if !isWantToGo && !isHaveBeen {
                try await ref.delete()  // Delete shop from user's saved shops if shop is not saved anywhere else
                
            } else {
                do {
                    // Set favorites bool to false if shop is saved somewhere else
                    try await ref.setData([
                        "isFavorite": false,
                        "updateTime": FieldValue.serverTimestamp()
                    ], merge: true)
                    
                } catch {
                    print("DEBUG: Failed to remove shop from \"Favorites\" with error: \(error.localizedDescription)")
                }
            }
            
            await fetchAllFavorites()
            
        } catch {
            print("DEBUG: Failed to delete shop from user's saved shops with error: \(error.localizedDescription)")
        }
    }
    
    
    func removeFromWantToGo(shop: CoffeeShop) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}  // get authenticated user
        
        let ref = Firestore.firestore().collection("users").document(uid).collection("savedShops").document(shop.id)
        let snapshot = try await ref.getDocument()
        let data = snapshot.data() ?? [:]
        
        let isFavorite = data["isFavorite"] as? Bool ?? false
        let isHaveBeen = data["isHaveBeen"] as? Bool ?? false

        do {
            if !isFavorite && !isHaveBeen {
                try await ref.delete()  // Delete shop from user's saved shops if shop is not saved anywhere else
                
            } else {
                do {
                    // Set favorites bool to false if shop is saved somewhere else
                    try await ref.setData([
                        "isWantToGo": false,
                        "updateTime": FieldValue.serverTimestamp()
                    ], merge: true)
                    
                } catch {
                    print("DEBUG: Failed to remove shop from \"Want To Go\" with error: \(error.localizedDescription)")
                }
            }
            
            await fetchAllWantToGo()
            
        } catch {
            print("DEBUG: Failed to delete shop from user's saved shops with error: \(error.localizedDescription)")
        }
    }
    
    
    func removeFromHaveBeen(shop: CoffeeShop) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}  // get authenticated user
        
        let ref = Firestore.firestore().collection("users").document(uid).collection("savedShops").document(shop.id)
        let snapshot = try await ref.getDocument()
        let data = snapshot.data() ?? [:]
        
        let isFavorite = data["isFavorite"] as? Bool ?? false
        let isWantToGo = data["isWantToGo"] as? Bool ?? false

        do {
            if !isFavorite && !isWantToGo {
                try await ref.delete()  // Delete shop from user's saved shops if shop is not saved anywhere else
                
            } else {
                do {
                    // Set have been bool to false if shop is saved somewhere else
                    try await ref.setData([
                        "isHaveBeen": false,
                        "updateTime": FieldValue.serverTimestamp()
                    ], merge: true)
                    
                } catch {
                    print("DEBUG: Failed to remove shop from \"Have Been\" with error: \(error.localizedDescription)")
                }
            }
            
            await fetchAllHaveBeen()
            
        } catch {
            print("DEBUG: Failed to delete shop from user's saved shops with error: \(error.localizedDescription)")
        }
    }
    

    func fetchAllFavorites() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}  // get authenticated user
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).collection("savedShops").whereField("isFavorite", isEqualTo: true).getDocuments() else { return }
        self.favorites = snapshot.documents.compactMap { doc in
            try? doc.data(as: SavedShop.self)
        }
    }
    
    
    func fetchAllWantToGo() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}  // get authenticated user
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).collection("savedShops").whereField("isWantToGo", isEqualTo: true).getDocuments() else { return }
        self.wantToGo = snapshot.documents.compactMap { doc in
            try? doc.data(as: SavedShop.self)
        }
    }
    
    
    func fetchAllHaveBeen() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}  // get authenticated user
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).collection("savedShops").whereField("isHaveBeen", isEqualTo: true).getDocuments() else { return }
        self.haveBeen = snapshot.documents.compactMap { doc in
            try? doc.data(as: SavedShop.self)
        }
    }
}

