//
//  RecordResponseModel.swift
//  orgo
//
//  Created by 김태현 on 2023/09/12.
//

import Foundation

struct RecordResponseModel: Codable {
    let id: Int
    let mountainId: Int
    let mountainName: String
    let date: String
}
