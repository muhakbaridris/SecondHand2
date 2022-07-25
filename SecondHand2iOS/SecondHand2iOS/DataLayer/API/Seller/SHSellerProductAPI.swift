//
//  SHSellerProductAPI.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 14/07/22.
//

import Foundation
import Alamofire

final class SHSellerProductAPI {
    func postSellerProduct(access_token: String,
                           name: String,
                           description: String,
                           base_price: Int,
                           categoryID: Int,
                           location: String,
                           imageName: String,
                           image: UIImage,
                           completionHandler: @escaping (Result<SellerProductResponseModel, AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/seller/product"
        let headers: HTTPHeaders = [
            "accept": "body",
            "access_token": access_token,
            "Content-Type": "multipart/form-data"
        ]
        let params: [String:String] = [
            "name": name,
            "description": description,
            "base_price": "\(base_price)",
            "category_ids": "\(categoryID)",
            "location": location,
        ]
        let imgData = image.jpegData(compressionQuality: 0.2)!
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            multipartFormData.append(
                imgData,
                withName: "image",
                fileName: imageName,
                mimeType: "image/jpeg")
        },
                  to: url,
                  method: .post,
                  headers: headers)
        .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseDecodable(of: SellerProductResponseModel.self ) { response in
            completionHandler(response.result)
        }.responseString { response in
            print(response)
        }
    }
    
    func getAllSellerProduct(
        access_token: String,
        completionHandler: @escaping (Result<[SHAllProductResponseModel], AFError>) -> Void
    ){
        let url = "https://market-final-project.herokuapp.com/seller/product"
        let headers: HTTPHeaders = [
            "accept": "body",
            "access_token" : access_token
        ]
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: [SHAllProductResponseModel].self) { response in
            completionHandler(response.result)
        }
    }
    
    func patchSellerProductID(
        access_token: String,
        productID: Int,
        status: String? = "",
        completionHandler: @escaping (Result<PatchSellerProductResponseModel, AFError>) -> Void
    ){
        let url = "https://market-final-project.herokuapp.com/seller/product/\(productID)"
        let headers: HTTPHeaders = [
            "accept": "body",
            "access_token": access_token,
            "Content-Type": "multipart/form-data"
        ]
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append((status?.data(using: .utf8))!, withName: "status")
        },
                  to: url,
                  method: .patch,
                  headers: headers
        ).responseDecodable(of: PatchSellerProductResponseModel.self) { response in
            completionHandler(response.result)
        }
    }
}
