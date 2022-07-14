//
//  SHSellerProductResponseModel.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 14/07/22.
//

import Foundation

struct SellerProductResponseModel: Decodable {
    let id: Int
    let name: String
    let description: String
    let base_price: Int
    let location: String
    let user_id: Int
    let image_url: String
    let image_name: String
    let updatedAt: String
    let createdAt: String
    let status: String
}
