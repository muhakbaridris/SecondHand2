//
//  SHLoginResponse.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 17/06/22.
//

import Foundation

struct LoginModel: Codable{
    let email: String
    let password: String
}

struct SHLoginResponseModel: Codable {
    let name: String
    let email: String
    let access_token: String
}
