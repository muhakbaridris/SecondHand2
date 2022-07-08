//
//  SHNotificationAPI.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 08/07/22.
//

import Foundation
import Alamofire

final class SHNotificationAPI {
    func getNotificationAll(access_token: String, completionHandler: @escaping (Result<[NotificationResponseModel],AFError>) -> Void) {
        let url = "https://market-final-project.herokuapp.com/notification"
        let headers: HTTPHeaders = ["accept": "body", "access_token": access_token]
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: [NotificationResponseModel].self) { response in
                completionHandler(response.result)
            }
//Check Response
//            .responseString { response in
//                print("responsenya \(response)")
//            }
    }
}
