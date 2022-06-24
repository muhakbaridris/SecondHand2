//
//  SHUpdateResponseModel.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 22/06/22.
//

import Foundation

struct UpdateModel: Codable {
    let full_name: String
    let email: String
    let password: String
    let phone_number: Int
    let address: String
    let image: String
    let city: String
}

struct UpdateResponseModel: Decodable {
    let id: Int
    let full_name: String
    let email: String
    let password: String
    let phone_number: String
    let address: String
    let image_RL: String
    let city: String
}
