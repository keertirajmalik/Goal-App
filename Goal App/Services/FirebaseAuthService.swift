//
//  FirebaseAuthService.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 14/09/22.
//

import FirebaseAuth
import Foundation

struct FirebaseAuthService {
    func authenticateUser(request: LoginRequest, completionHandler: @escaping (_ result: LoginResponse?) -> Void) {
        Auth.auth().signIn(withEmail: request.userEmail, password: request.userPassword) { (result: AuthDataResult?, error: Error?) in
            let user = User(userName: result?.user.displayName, userId: result?.user.uid, email: result?.user.email)
            let response = LoginResponse(errorMessage: error?.localizedDescription, data: user)
            _ = completionHandler(response)
        }
    }
}
