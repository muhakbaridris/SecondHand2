//
//  SHProductDataResponse.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 30/06/22.
//

import Foundation

// MARK: - SHProductDataResponseModelElement
struct SHProductDataResponseModel: Decodable {
    let id: Int?
    let name: String?
    let base_price: Int?
    let image_url: String?
    let image_name : String?
    let location: String?
    let user_id: Int?
    let status: Status?
//    let createdAt, updatedAt: String?
    let categories: [Category]?
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
