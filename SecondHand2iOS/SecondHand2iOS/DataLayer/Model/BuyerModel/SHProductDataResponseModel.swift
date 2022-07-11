//
//  SHProductDataResponse.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 30/06/22.
//

import Foundation

// MARK: - SHProductDataResponseModelElement
struct SHAllProductResponseModel: Codable {
    let id: Int?
    let name: String?
    let base_price: Int?
    let image_url: String?
    let image_name, location: String?
    let user_id: Int?
    let Categories: [kategori]?
}

struct SHProductIDResponseModel: Codable {
    let id: Int?
    let name: String?
    let base_price: Int?
    let image_url, image_name: String?
    let location: String?
    let user_id: Int?
    let status: Status?
    let Categories: [kategori]
    let User: user_detail?
}

struct SHBuyerProductIDUserOnlyModel: Decodable {
    let User: user_detail?
}

// MARK: - Category
struct kategori: Codable {
    let id: Int?
    let name: String?
}

enum Status: String, Codable {
    case available = "available"
    case sold = "sold"
}

// MARK: - User
struct user_detail: Codable {
    let id: Int?
    let full_name, email, phone_number, address: String?
    let image_url: String?
    let city: String?
}

