//
//  SHSellerOrderPatchResponseModel.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 25/07/22.
//

import Foundation

struct SHSellerOrderPatchResponseModel: Decodable {
    let id: Int?
    let productID: Int?
    let buyerID: Int?
    let price: Int?
    let transactionDate: String?
    let productName: String?
    let basePrice: Int?
    let imageProduct: String?
    let status: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case productID = "product_id"
        case buyerID = "buyer_id"
        case price = "price"
        case transactionDate = "transaction_date"
        case productName = "product_name"
        case basePrice = "base_price"
        case imageProduct = "image_product"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
}

