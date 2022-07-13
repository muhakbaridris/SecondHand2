//
//  SHChangeAccountResponseModel.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 13/07/22.
//

import Foundation

struct ChangeAccountModel: Encodable {
    let full_name: String
    let phone_number: String
    let address: String
    let image: String
    let city: String
}

struct ChangeAccountResponseModel: Decodable {
    let id: Int
    let full_name: String
    let email: String
    let phone_number: String
    let image_url: String
    let address: String
    let city: String
}
