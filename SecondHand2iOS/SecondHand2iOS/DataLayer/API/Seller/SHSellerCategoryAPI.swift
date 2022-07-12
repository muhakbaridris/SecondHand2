//
//  SHSellerCategoryAPI.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/07/22.
//

import Foundation
import Alamofire

final class SHSellerCategoryAPI {
    func SellerCategoryAll(completionHandler: @escaping (Result<[SellerProductResponseModel], AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/seller/category"
        let headers: HTTPHeaders = [.accept("*/*")]
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: [SellerProductResponseModel].self) { response in
            completionHandler(response.result)
        }
    }
}
