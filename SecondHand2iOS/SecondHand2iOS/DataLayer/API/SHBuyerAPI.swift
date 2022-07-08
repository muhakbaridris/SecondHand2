//
//  SHBuyerAPI.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 07/07/22.
//

import Foundation
import Alamofire

class SHBuyerAPI{
    func getAllBuyerProduct(completionHandler: @escaping (Result<[SHAllProductResponseModelElement], AFError>) -> Void){
        let url = "https://market-final-project.herokuapp.com/buyer/product"
        let headers: HTTPHeaders = [.accept("body")]
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [SHAllProductResponseModelElement].self){
            response in completionHandler(response.result)
        }
    }
    
    func getBuyerProductId(id: Int, completionHandler: @escaping (Result<SHProductIDResponseModel, AFError>) -> Void){
        let url = "https://market-final-project.herokuapp.com/buyer/product/\(id)"
        let headers: HTTPHeaders = [.accept("body"), .contentType("application/json; charset=utf-8")]
        print(url)
        AF.request(url,
                   method: .get, headers: headers).responseDecodable(of: SHProductIDResponseModel.self) {
            response in completionHandler(response.result)
        }
    }
}

extension SHBuyerAPI{
    func getAllBuyerOrder(token: String, completionHandler: @escaping (Result<[SHAllBuyerOrderResponseModelElement], AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/buyer/order"
        let headers: HTTPHeaders = ["accept": "body", "access_token" : "\(token)"]
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [SHAllBuyerOrderResponseModelElement].self) {
            response in completionHandler(response.result)
        }
    }
    
    func getBuyerOrderId(token: String, id: Int, completionHandler: @escaping(Result<SHBuyerOrderIDResponseModel, AFError>) -> Void){
        let url = "https://market-final-project.herokuapp.com/buyer/order/\(id)"
        let headers: HTTPHeaders = ["accept": "body", "access_token" : "\(token)"]
        AF.request(url, method: .get, headers: headers).responseDecodable(of: SHBuyerOrderIDResponseModel.self) {
            response in completionHandler(response.result)
        }
    }
}
