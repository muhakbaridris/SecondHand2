//
//  SHBuyerAPI.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 07/07/22.
//

import Foundation
import Alamofire

class SHBuyerAPI{
    func getAllBuyerProduct(completionHandler: @escaping (Result<[SHAllProductResponseModel], AFError>) -> Void){
        let url = "https://market-final-project.herokuapp.com/buyer/product"
        let headers: HTTPHeaders = [.accept("body")]
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: [SHAllProductResponseModel].self){ response in
            completionHandler(response.result)
        }
    }
    
    func getBuyerProductId(id: Int,
                           completionHandler: @escaping (Result<SHProductIDResponseModel, AFError>) -> Void){
        let url = "https://market-final-project.herokuapp.com/buyer/product/\(id)"
        let headers: HTTPHeaders = [.accept("body"),
                                    .contentType("application/json; charset=utf-8")]
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: SHProductIDResponseModel.self) {
            response in completionHandler(response.result)
        }
    }
    
    func getBuyerProductIdUserOnly(id: Int,
                           completionHandler: @escaping (Result<SHBuyerProductIDUserOnlyModel, AFError>) -> Void){
        let url = "https://market-final-project.herokuapp.com/buyer/product/\(id)"
        let headers: HTTPHeaders = [.accept("body"),
                                    .contentType("application/json; charset=utf-8")]
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: SHBuyerProductIDUserOnlyModel.self) {
            response in completionHandler(response.result)
        }
    }

}
