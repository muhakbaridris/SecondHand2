//
//  getUserAccessTokenDefaults.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 14/07/22.
//

import Foundation

struct AccessTokenCache {
    static let key = "access_token"
    static let userDefaults = UserDefaults.standard
    static func save(_ value: String) {
        userDefaults.set(value, forKey: key)
    }
    static func get() -> String {
        return userDefaults.string(forKey: key)!
    }
}
