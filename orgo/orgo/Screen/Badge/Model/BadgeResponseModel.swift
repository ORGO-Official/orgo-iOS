//
//  BadgeListResponseModel.swift
//  orgo
//
//  Created by 김태현 on 2023/10/14.
//

import Foundation

struct BadgeResponseModel: Decodable {
    let id: Int
    let objective: String
    let description: String
    let acquiredTime: String
}
