//
//  UpdateTokenResponseModel.swift
//  orgo
//
//  Created by 김태현 on 2023/08/16.
//

import Foundation

struct UpdateTokenResponseModel: Codable {
    let accessToken, refreshToken: String
}
