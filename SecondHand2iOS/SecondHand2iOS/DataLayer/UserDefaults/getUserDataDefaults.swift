//
//  getUserDataDefaults.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 08/07/22.
//

import Foundation

struct UserProfileCache {
    static let key = "userProfileCache"
    static let userDefaults = UserDefaults.standard
    static func save(_ value: UserDataResponseModel!) {
        userDefaults.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    static func get() -> UserDataResponseModel! {
        var userData: UserDataResponseModel!
        if let data = userDefaults.value(forKey: key) as? Data {
            userData = try? PropertyListDecoder().decode(UserDataResponseModel.self, from: data)
            return userData!
        } else {
            return userData
        }
    }
}
