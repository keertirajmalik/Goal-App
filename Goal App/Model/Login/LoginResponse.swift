//
//  LoginResponse.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 14/09/22.
//

import Foundation

struct LoginResponse: Decodable {
    let errorMessage: String?
    let data: User?
}

struct User: Decodable {
    let userName: String?
    let userId: String?
    let email: String?
}
