//
//  SHRegisterResponseModel.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 21/06/22.
//

import Foundation

struct RegisUpdateModel: Codable {
    let full_name: String
    let email: String
    let password: String
    let phone_number: Int
    let address: String
    let image: String
    let city: String
}

struct RegisUpdateResponseModel: Decodable {
    let id: Int
    let full_name: String
    let email: String
    let password: String
    let phone_number: String
    let address: String
    let image_RL: String
    let city: String
}
