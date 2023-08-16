//
//  EmptyResponseModel.swift
//  orgo
//
//  Created by 김태현 on 2023/08/16.
//

import Alamofire

struct EmptyResponseModel: Codable, EmptyResponse {
    static func emptyValue() -> EmptyResponseModel {
        EmptyResponseModel.init()
    }
}
