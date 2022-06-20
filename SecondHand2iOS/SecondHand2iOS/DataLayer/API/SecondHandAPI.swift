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

typealias Handler = (Swift.Result<Any?, APIError>) -> Void

class RequestAPI {
    
    static let shareInstance = RequestAPI()
    
    func loginSecondHand(login: LoginModel, completionHandler: @escaping Handler) {
        let url = "https://market-final-project.herokuapp.com/auth/login"
        let headers: HTTPHeaders = [
            .accept("schema"),
            .contentType("application/json")
        ]

        AF.request(url,
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
        .response { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 201 {
                        completionHandler(.success(json))
                    } else {
                        completionHandler(.failure(.custom(message: "Check Network")))
                    }
                } catch {
                    print(error.localizedDescription)
                    completionHandler(.failure(.custom(message: "Try Again")))
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(.failure(.custom(message: "Try Again")))
            }

        }
    }
    
    
}

