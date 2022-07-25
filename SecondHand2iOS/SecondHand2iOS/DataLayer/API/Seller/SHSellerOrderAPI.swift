//
//  SHSellerOrderAPI.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 15/07/22.
//

import Foundation
import Alamofire

final class SHSellerOrderAPI{
    
    func getAllSellerOrder(access_token: String, status: String? = nil, completionHandler: @escaping (Result<[SHSellerOrderResponseModel], AFError>) -> Void) {
        if status == "pending" || status == "accepted" || status == "declined" {
            let url = "https://market-final-project.herokuapp.com/seller/order?status=\(status!)"
            let headers: HTTPHeaders = ["accept": "body",
                                        "access_token": "\(access_token)"]
            AF.request(url,
                       method: .get,
                       headers: headers)
            .responseDecodable(of: [SHSellerOrderResponseModel].self){
                response in completionHandler(response.result)
            }
        } else {
            let url = "https://market-final-project.herokuapp.com/seller/order"
            let headers: HTTPHeaders = ["accept": "body",
                                        "access_token": "\(access_token)"]
            AF.request(url,
                       method: .get,
                       headers: headers).responseDecodable(of: [SHSellerOrderResponseModel].self){
                response in completionHandler(response.result)
            }
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
    
    func patchSellerOrderID(
        access_token: String,
        id: Int,
        status: String,
        completionHandler: @escaping (Result<SHSellerOrderPatchResponseModel, AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/seller/order/\(id)"
        let headers: HTTPHeaders = [
            "accept": "body",
            "access_token": "\(access_token)",
            "Content-Type": "multipart/form-data"
        ]
            AF.upload(multipartFormData: { multipartFromData in
                multipartFromData.append(status.data(using: .utf8)!, withName: "status")
            },
                      to: url,
                      method: .patch,
                      headers: headers)
            .responseDecodable(of: SHSellerOrderPatchResponseModel.self) { response in
                completionHandler(response.result)
            }
    }
}
