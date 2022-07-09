//
//  SHAuthAPI.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 17/06/22.
//

import Foundation
import Alamofire

class SHAuthAPI {
    
    func registerUserSecondHand(register: RegisterModel,
                            completionHandler: @escaping (Result<RegisterResponseModel, AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/auth/register"
        let headers: HTTPHeaders = [.accept("body"),
                                    .contentType("multipart/form-data")]
        AF.upload(multipartFormData: { multipartFormData in
            //code here
        },
                  to: url,
                  method: .post,
                  headers: headers).response { response in
            //code here
        }
    }
    
    func registerUserSecondHand(registerData: RegisterModelMini,
                                completionHandler: @escaping (Result<RegisterResponseModel, AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/auth/register"
        let params: [String:String] = ["full_name":registerData.full_name,
                                       "email":registerData.email,
                                       "password":registerData.password
                                      ]
        let headers: HTTPHeaders = [.accept("body"),
                                    .contentType("multipart/form-data")]
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
        },
                  to: url,
                  method: .post,
                  headers: headers)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
            
        })
        .responseDecodable(of: RegisterResponseModel.self) { response in
            completionHandler(response.result)
        }
    }
    
    func getUserDataSecondHand(access_token: String,
                               completionHandler: @escaping (Result<UserDataResponseModel, AFError>) -> Void){
        let url = "https://market-final-project.herokuapp.com/auth/user"
        let headers: HTTPHeaders = ["accept": "body",
                                    "access_token": "\(access_token)"]
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: UserDataResponseModel.self) { response in
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
        
    func updateUserSecondHand(access_token: String,
                              register: UpdateModel,
                              completionHandler: @escaping (Result<UpdateResponseModel, AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/auth/user"
        let headers: HTTPHeaders = ["accept": "body",
                                    "access_token": "\(access_token)",
                                    "Content-Type": "multipart/form-data"]
        AF.upload(multipartFormData: { multipartFormData in
            //code here
        },
                  to: url,
                  method: .put,
                  headers: headers).response { response in
            //code here
        }
    }
    
    func changePasswordSecondHand(changePasswrdData: ChangePasswordModel ,
                                  access_token: String,
                                  completionHandler: @escaping (Result<ChangePasswordResponseModel, AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/auth/change-password"
        let headers: HTTPHeaders = ["accept": "body",
                                    "access_token": "\(access_token)",
                                    "Content-Type": "multipart/form-data"]
        let params: [String:String] = ["current_password": changePasswrdData.current_password,
                                       "new_password": changePasswrdData.new_password,
                                       "confirm_password": changePasswrdData.confirm_password
                                      ]
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
        },
                  to: url,
                  method: .put,
                  headers: headers)
        .responseDecodable(of: ChangePasswordResponseModel.self) { response in
            completionHandler(response.result)
        }
    }
}

