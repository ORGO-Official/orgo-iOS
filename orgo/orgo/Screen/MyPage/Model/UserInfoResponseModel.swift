//
//  UserInfoResponseModel.swift
//  orgo
//
//  Created by 김태현 on 2023/09/14.
//

import Foundation

struct UserInfoResponseModel: Codable {
    let id: Int
    let nickname: String
    let email: String
    let profileImage: String
    let loginType: String
}
