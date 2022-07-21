//
//  SHSellerOrderAllResponseModel.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 15/07/22.
//

import Foundation

struct SHSellerOrderResponseModel: Decodable {
    let id, product_id, buyer_id, price: Int?
    let transaction_date, product_name: String?
    let base_price: Int?
    let image_product: String?
    let status: String?
    let Product: Product?
    let User: User?
}

// MARK: - Product
struct Product: Decodable {
    let name, product_description: String?
    let base_price: Int?
    let image_url: String?
    let image_name, location: String?
    let user_id: Int?
    let status: String?
    let user: User?
}

// MARK: - User
struct User: Decodable {
    let id: Int?
    let full_name, email, phone_number, address: String?
    let city: String?
}
