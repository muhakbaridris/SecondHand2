//
//  getSellerCategoryDefaults.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/07/22.
//

import Foundation

struct CategoryCache {
    static let key = "categoryProductCache"
    static let userDefaults = UserDefaults.standard
    static func save(_ value: [SellerCategoryResponseModel]!) {
        userDefaults.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    static func get() -> [SellerCategoryResponseModel]! {
        var userData: [SellerCategoryResponseModel]!
        if let data = userDefaults.value(forKey: key) as? Data {
            userData = try? PropertyListDecoder().decode([SellerCategoryResponseModel].self, from: data)
            return userData!
        } else {
            return userData
        }
    }
}
