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
    let basePrice: Int?
    let imageURL: String?
    let imageName : String?
    let location: String?
    let userID: Int?
//    let status: Status?
//    let createdAt, updatedAt: String?
    let categories: [Category]?
}

// MARK: - Category
struct Category: Decodable {
    let id: Int?
    let name: String?
}

//enum Status: Decodable {
//    case available
//    case sold
//}
