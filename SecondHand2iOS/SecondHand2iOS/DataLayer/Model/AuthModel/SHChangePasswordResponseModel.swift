//
//  SHChangePasswordResponseModel.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 09/07/22.
//

import Foundation

struct ChangePasswordModel: Encodable {
    let current_password: String
    let new_password: String
    let confirm_password: String
}

struct ChangePasswordResponseModel: Decodable {
    let name: String
    let message: String
}
