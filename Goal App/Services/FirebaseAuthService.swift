//
//  FirebaseAuth.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 13/09/22.
//

import FirebaseAuth
import Foundation

class FirebaseAuthService {
    public static let shared = FirebaseAuthService()

    public func login(email: String, password: String) -> String? {
        var errorMessage: String?
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if error != nil {
                errorMessage = error?.localizedDescription
            } else {
                print("Logged in")
            }
        }
        return errorMessage
    }
    
    public func signUp(email: String, password: String) -> String? {
        var errorMessage: String?
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if error != nil {
                errorMessage = error?.localizedDescription
            }
        }
        return errorMessage
    }
}
