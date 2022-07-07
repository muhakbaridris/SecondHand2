//
//  SHRegisterResponseModel.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 21/06/22.
//

import Foundation

struct RegisterModel: Codable {
    let full_name: String
    let email: String
    let password: String
    let phone_number: Int
    let address: String
    let image: String
    let city: String
}

struct RegisterModelMini: Codable {
    let full_name: String
    let email: String
    let password: String
}

struct RegisterResponseModel: Decodable {
    let id: Int
    let full_name: String
    let email: String
}
