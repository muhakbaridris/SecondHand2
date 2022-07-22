//
//  SHNotificationResponseModel.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 08/07/22.
//

import Foundation

struct NotificationResponseModel: Codable {
    let id, product_id: Int
    let product_name, base_price: String
    let bid_price: Int?
    let image_url: String?
    let transaction_date: String?
    let status, seller_name: String
    let buyer_name: String?
    let receiver_id: Int
    let updatedAt: String
    let Product: ProductDetail?
    let User: user?
}

struct ProductDetail: Codable {
    let id: Int
    let name: String
    let description: String?
    let base_price: Int
    let image_url: String?
    let image_name: String?
    let location: String
    let user_id: Int
    let status: String
}

struct user: Codable {
    let id: Int
    let full_name, email, phone_number, address: String
    let image_url: String
    let city: String
}
