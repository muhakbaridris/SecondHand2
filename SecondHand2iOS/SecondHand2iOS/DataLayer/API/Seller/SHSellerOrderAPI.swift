//
//  SHSellerOrderAPI.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 15/07/22.
//

import Foundation
import Alamofire

final class SHSellerOrderAPI{
    
    func getAllSellerOrder(access_token: String, status: String, completionHandler: @escaping (Result<[SHSellerOrderResponseModel], AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/seller/order?status=\(status)"
        let headers: HTTPHeaders = ["accept": "body",
                                    "access_token": "\(access_token)"]
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [SHSellerOrderResponseModel].self){
            response in completionHandler(response.result)
        }
    }
    
    func getSellerOrderId(access_token: String, id: Int, completionHandler: @escaping (Result<SHSellerOrderIDResponseModel, AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/seller/order/\(id)"
        let headers: HTTPHeaders = ["accept": "body",
                                    "access_token": "\(access_token)"]
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: SHSellerOrderIDResponseModel.self){
            response in completionHandler(response.result)
        }
    }
}
