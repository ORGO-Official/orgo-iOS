//
//  URLResource.swift
//  orgo
//
//  Created by 김태현 on 2023/07/16.
//

import UIKit

struct URLResource<T: Decodable> {
    
    // MARK: - Variables and Properties
    
    let baseURL = URL(string: "http://34.64.36.223:8080")
    let path: String
    var resultURL: URL {
        baseURL.flatMap { URL(string: $0.absoluteString + path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) }!
    }
    
    // MARK: - Functions
    
    func judgeError(statusCode: Int) -> Result<T, APIError> {
        switch statusCode {
        case 400...409:
            return .failure(.decode)
        case 500:
            return .failure(.http(status: statusCode))
        default:
            return .failure(.unknown(status: statusCode))
        }
    }
}
