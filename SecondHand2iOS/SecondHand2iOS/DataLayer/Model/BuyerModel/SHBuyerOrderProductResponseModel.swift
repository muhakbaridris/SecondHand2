//
//  SHBuyerOrderProductResponseModel.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 03/07/22.
//

import Foundation


// MARK: - SHBuyerOrderAllResponseElement
struct SHBuyerOrderAllResponseModel: Decodable {
    let id : Int
    let product_id : Int
    let buyer_id : Int
    let price: Int
//    let transactionDate: NSNull?
    let product_name: String?
    let base_price: String
    let image_product: String?
    let status: SHBuyerOrderAllResponseStatus
    let product: Products?
    let user: Users?
}

// MARK: - Product
struct Products: Decodable {
    let name: String?
    let product_description: String?
    let base_price: Int?
    let image_url: String?
    let image_name: String?
    let location: String?
    let user_id: Int?
    let status: ProductStatus?
    let user: Users?
}

enum ProductStatus: String, Decodable {
    case available = "available"
    case sold = "sold"
}

// MARK: - User
struct Users : Decodable {
    let id: Int?
    let full_name, email, phone_number, address: String?
    let city: String?
}

enum SHBuyerOrderAllResponseStatus: String, Decodable {
    case declined = "declined"
    case pending = "pending"
}
