//
//  FirebaseAuthService.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 14/09/22.
//

import FirebaseAuth
import Foundation

struct FirebaseAuthService {
    func authenticateUser(request: LoginRequest) async -> LoginResponse {
        do {
            let result = try await Auth.auth().signIn(withEmail: request.userEmail, password: request.userPassword)
            let user = User(userName: result.user.displayName, userId: result.user.uid, email: result.user.email)
            return LoginResponse(errorMessage: nil, data: user)

        } catch {
            return LoginResponse(errorMessage: error.localizedDescription, data: nil)
        }
    }
}
