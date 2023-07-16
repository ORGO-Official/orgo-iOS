//
//  APIError.swift
//  orgo
//
//  Created by 김태현 on 2023/07/16.
//

enum APIError: Error {
    case decode
    case http(status: Int)
    case unknown(status: Int)
    case unable
}

extension APIError: CustomStringConvertible {
    var description: String {
        switch self {
        case .decode:
            return "Decode Error"
        case let .http(status):
            return "HTTP Error: \(status)"
        case let .unknown(status):
            return "Unknown Error: \(status)"
        case .unable:
            return "Use API Unable"
        }
    }
}
