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
