//
//  LoginValidation.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 14/09/22.
//

import Foundation

struct Validation {
    func validateLogin(request: LoginRequest) -> ValidationResult {
        if request.userEmail.count > 0, request.userPassword.count > 0 {
            if request.userEmail.validateEmail() {
                return ValidationResult(success: true, errorMessage: nil)
            } else {
                return ValidationResult(success: false, errorMessage: "Please enter a valid email")
            }
        }
        return ValidationResult(success: false, errorMessage: "Please enter valid credentials")
    }
}
