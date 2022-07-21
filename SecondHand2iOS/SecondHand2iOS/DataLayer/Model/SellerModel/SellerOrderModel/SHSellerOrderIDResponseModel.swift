//
//  SHSellerOrderIDResponseModel.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 22/07/22.
//

import Foundation

struct SHSellerOrderIDResponseModel: Decodable {
    let id: Int?
    let product_id: Int?
    let buyer_id: Int?
    let price: Int?
    let transaction_date: String?
    let product_name: String?
    let base_price: Int?
    let image_product: String?
    let status: String?
    let updatedAt: String?
    var Product: ProductOrderIDResponse?
    let User: UserOrderIDResponse?
}

struct ProductOrderIDResponse: Decodable {
    let name: String
    let description: String?
    let base_price: Int
    let image_url: String?
    let image_name: String?
    let location: String
    let user_id: Int
    let status: String
}

struct UserOrderIDResponse: Decodable {
    let id: Int
    let full_name, email, phone_number, address: String
    let image_url: String
    let city: String
}
