//
//  SHBuyerOrderAPI.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 12/07/22.
//

import Foundation
import Alamofire

final class SHBuyerOrderAPI {
    func postBuyerOrder(access_token: String, bid: SHPostBuyerOrderModel, completionHandler: @escaping (Result<SHPostBuyerOrderResponseModel, AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/buyer/order"
        let headers: HTTPHeaders = ["accept": "body",
                                    "access_token": "\(access_token)",
                                    "Content-Type": "application/json"
        ]
        AF.request(url,
                   method: .post,
                   parameters: bid,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
        .responseDecodable(of: SHPostBuyerOrderResponseModel.self ) { response in
            completionHandler(response.result)
        }
    }
    
    func getAllBuyerOrder(token: String, completionHandler: @escaping (Result<[SHAllBuyerOrderResponseModel], AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/buyer/order"
        let headers: HTTPHeaders = ["accept": "body", "access_token" : "\(token)"]
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [SHAllBuyerOrderResponseModel].self) {
            response in completionHandler(response.result)
        }
    }
    
    func getBuyerOrderId(token: String,
                         id: Int,
                         completionHandler: @escaping(Result<SHBuyerOrderIDResponseModel, AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/buyer/order/\(id)"
        let headers: HTTPHeaders = ["accept": "body",
                                    "access_token" : "\(token)"]
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: SHBuyerOrderIDResponseModel.self) {
            response in completionHandler(response.result)
        }
    }
}
