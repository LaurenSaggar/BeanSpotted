//
//  AuthViewModel.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 2/1/26.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    // Ensures user stays logged in (unless user logged out) when they return to app
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()  // use await here to ensure userSession is started before fetchUser() is called
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(firstName: String, lastName: String, withEmail email: String, username: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, firstName: firstName, lastName: lastName, email: email, username: username, bio: "", createTime: Date.now, modifyTime: Date.now)
            let encodedUser = try Firestore.Encoder().encode(user)  // Encode user in JSON for upload to firebase
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
            print(currentUser ?? "Failed to fetch user")
            
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()  // signs out user on backend
            self.userSession = nil  // wipes out user session and takes us back to login screen
            self.currentUser = nil  // wipes out current user data model
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}  // get authenticated user
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}  // get firebase store user
        self.currentUser = try? snapshot.data(as: User.self)  // set firebase user to current user for app activity
    }
}

