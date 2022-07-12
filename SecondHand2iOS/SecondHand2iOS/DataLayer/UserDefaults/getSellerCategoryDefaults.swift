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
    static func save(_ value: [SellerProductResponseModel]!) {
        userDefaults.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    static func get() -> [SellerProductResponseModel]! {
        var userData: [SellerProductResponseModel]!
        if let data = userDefaults.value(forKey: key) as? Data {
            userData = try? PropertyListDecoder().decode([SellerProductResponseModel].self, from: data)
            return userData!
        } else {
            return userData
        }
    }
}
