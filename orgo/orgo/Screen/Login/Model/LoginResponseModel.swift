//
//  LoginResponseModel.swift
//  orgo
//
//  Created by 김태현 on 2023/08/16.
//

import Foundation

struct LoginResponseModel: Codable {
    let accessToken: String
    let refreshToken: String
}
