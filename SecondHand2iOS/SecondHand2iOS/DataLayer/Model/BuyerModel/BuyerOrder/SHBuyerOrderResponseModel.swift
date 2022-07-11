//
//  SHBuyerOrderResponseModel.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 07/07/22.
//

import Foundation

struct SHAllBuyerOrderResponseModel : Decodable {
    let id : Int?
    let product_id : Int?
    let buyer_id : Int?
    let price: Int?
//    let transactionDate: String?
    let product_name: String?
    let base_price: String?
    let image_product: String?
    let status: String?
//    let product: Product?
//    let user: User?
}

struct SHBuyerOrderIDResponseModel: Decodable {
    let id, product_id, buyer_id, price: Int?
    let product_name, base_price: String?
    let image_product: String?
    let status: String?
//    let product: Product?
//    let user: User?
}

struct SHPostBuyerOrderModel: Encodable {
    let product_id: Int
    let bid_price: Int
}

struct SHPostBuyerOrderResponseModel: Decodable {
    let id: Int
    let buyer_id: Int
    let product_id: Int
    let price: Int
    let product_name: String
    let base_price: String
    let updatedAt: String
    let createdAt: String
    let status: String
}
