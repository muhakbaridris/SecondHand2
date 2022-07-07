//
//  SHProductDataResponse.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 30/06/22.
//

import Foundation

// MARK: - SHProductDataResponseModelElement
struct SHAllProductResponseModelElement: Decodable {
    let id: Int?
    let name: String?
    let base_price: Int?
    let image_url: String?
    let image_name, location: String?
    let user_id: Int?
    let status: Status?
//    let createdAt, updatedAt: String?
    let categories: [Category]?
}

struct SHProductIDResponseModel: Decodable {
    let id: Int?
    let name: String?
//    let shProductIDResponseModelDescription: NSNull?
    let base_price: Int?
    let image_url, image_name: String?
    let location: String?
    let user_id: Int?
    let status: Status?
//    let createdAt, updatedAt: String?
    let categories: [Category]?
    let user: User?
}

// MARK: - Category
struct Category: Decodable {
    let id: Int?
    let name: String?
}

enum Status: String, Decodable {
    case available = "available"
    case sold = "sold"
}

// MARK: - User
struct User : Decodable {
    let id: Int?
    let full_name, email, phone_number, address: String?
    let image_url: String?
    let city: String?
}
