//
//  SHBuyerAPI.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 30/06/22.
//

import Foundation
import Alamofire

class SHBuyerProductAPI {
    fileprivate var baseUrl = ""
    typealias productCallBack = (_ product:[SHProductDataResponseModel]?, _ status: Bool, _ message:String) -> Void
    var callBack:productCallBack?
    init(baseUrl: String) {
            self.baseUrl = baseUrl
        }
    
    
    
    func getAllBuyerProduct(endPoint:String) {
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            guard let data = responseData.data else {
                self.callBack?(nil, false, "")
                return}
            do {
            let products = try JSONDecoder().decode([SHProductDataResponseModel].self, from: data)
//                print(products)
                self.callBack?(products, true,"")
                
            } catch {
                print(error.localizedDescription)
                self.callBack?(nil, false, error.localizedDescription)
            }
            
        }
    }
    
    func completionHandler(callBack: @escaping productCallBack) {
        self.callBack = callBack
    }
    
    func getBuyerProductId(id: Int, completionHandler: @escaping (Result<SHProductDataIdResponseModel, AFError>) -> Void){
        let url = "https://market-final-project.herokuapp.com/buyer/product/\(id)"
        let headers: HTTPHeaders = [.accept("body"), .contentType("application/json; charset=utf-8")]
        AF.request(url,
                   method: .get, headers: headers).responseDecodable(of: SHProductDataIdResponseModel.self) {
            response in completionHandler(response.result)
        }
    }
}
