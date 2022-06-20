//
//  SecondHandAPI.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 17/06/22.
//

import Foundation
import Alamofire

enum APIError: Error {
    case custom(message: String)
}

class RequestAPI {
    
    func registerUserSecondHand(register: RegisUpdateModel,
                            completionHandler: @escaping (Result<RegisUpdateResponseModel, AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/auth/register"
        let headers: HTTPHeaders = [.accept("body"), .contentType("multipart/form-data")]
        AF.request(url,
                   method: .post,
                   parameters: register,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
        .responseDecodable(of: RegisUpdateResponseModel.self ) { response in
            completionHandler(response.result)
        }
    }
        
        func updateUserSecondHand(register: RegisUpdateModel    ,
                                completionHandler: @escaping (Result<RegisUpdateResponseModel, AFError>) -> Void) {
            let url = "https://market-final-project.herokuapp.com/auth/register"
            let headers: HTTPHeaders = [.accept("body"), .contentType("multipart/form-data")]
            AF.request(url,
                       method: .post,
                       parameters: register,
                       encoder: JSONParameterEncoder.default,
                       headers: headers)
            .responseDecodable(of: RegisUpdateResponseModel.self ) { response in
                completionHandler(response.result)
            }
    }
    
    func loginUserSecondHand(login: LoginModel,
                         completionHandler: @escaping (Result<LoginResponseModel, AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/auth/login"
        let headers: HTTPHeaders = [ .accept("schema"), .contentType("application/json") ]
        AF.request(url,
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
        .responseDecodable(of: LoginResponseModel.self ) { response in
            completionHandler(response.result)
        }
    }
}

