//
//  SHBuyerOrderAPI.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 03/07/22.
//

import Foundation
import Alamofire

final class SHBuyerOrderAPI{
        fileprivate var baseUrl = ""
        typealias orderCallBack = (_ product:[SHBuyerOrderAllResponseModel]?, _ status: Bool, _ message:String) -> Void
        var callBack:orderCallBack?
        init(baseUrl: String) {
                self.baseUrl = baseUrl
            }
    
    func getAllBuyerOrder(endPoint:String, token: String) {
        let headers: HTTPHeaders = ["access_token": "\(token)"]
            AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers, interceptor: nil).response { (responseData) in
                guard let data = responseData.data else {
                    self.callBack?(nil, false, "")
                    return}
                do {
                let orders = try JSONDecoder().decode([SHBuyerOrderAllResponseModel].self, from: data)
                    self.callBack?(orders, true,"")
    
                } catch {
                    print(error.localizedDescription)
                    self.callBack?(nil, false, error.localizedDescription)
                }
    
            }
        }
    
        func completionHandler(callBack: @escaping orderCallBack) {
            self.callBack = callBack
        }
}


    
