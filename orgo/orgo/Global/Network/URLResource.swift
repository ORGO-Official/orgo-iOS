//
//  URLResource.swift
//  orgo
//
//  Created by 김태현 on 2023/07/16.
//

import UIKit

struct URLResource<T: Decodable> {
    
    // MARK: - Variables and Properties
    
    // TODO: - baseURL 변경
    let baseURL = URL(string: "https://temp")
    let path: String
    var resultURL: URL {
        return path.contains("https")
        ? URL(string: path)!
        : baseURL.flatMap { URL(string: $0.absoluteString + path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) }!
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
