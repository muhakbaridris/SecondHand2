//
//  URLRequestBuilder.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 17/06/22.
//

import Foundation

enum HttpMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

final class URLRequestBuilder {
    private var request: URLRequest
    
    init(url: URL) {
        request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    func appId(_ id: String) -> URLRequestBuilder {
        request.addValue(id, forHTTPHeaderField: "app-id")
        return self
    }
    
    func httpMethod(_ method: HttpMethod) -> URLRequestBuilder {
        request.httpMethod = method.rawValue
        return self
    }
    
    func addHeader(key: String, value: String) -> URLRequestBuilder {
        request.addValue(key, forHTTPHeaderField: value)
        return self
    }
    
    func build() -> URLRequest { request }
}
