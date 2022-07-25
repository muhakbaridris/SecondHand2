//
//  SHSellerProductResponseModel.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 14/07/22.
//

import Foundation

struct SellerProductResponseModel: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let base_price: Int?
    let location: String?
    let user_id: Int?
    let image_url: String?
    let image_name: String?
    let updatedAt: String?
    let createdAt: String?
    let status: String?
}

struct PatchSellerProductResponseModel: Decodable {
    let id: Int?
    let name: String?
    let shSellerOrderIDResponseModelDescription: String?
    let basePrice: Int?
    let imageURL: String?
    let imageName: String?
    let location: String?
    let userID: Int?
    let status: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case shSellerOrderIDResponseModelDescription = "description"
        case basePrice = "base_price"
        case imageURL = "image_url"
        case imageName = "image_name"
        case location = "location"
        case userID = "user_id"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
}
