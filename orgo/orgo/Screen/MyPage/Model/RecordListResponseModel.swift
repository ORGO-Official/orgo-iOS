//
//  RecordResponseModel.swift
//  orgo
//
//  Created by 김태현 on 2023/09/12.
//

import Foundation

struct RecordListResponseModel: Codable {
    let climbedAltitude: Double
    let climbingCnt: Int
    let climbingRecordDtoList: [ClimbingRecord]
}

struct ClimbingRecord: Codable {
    let id: Int
    let mountainId: Int
    let mountainName: String
    let date: String
    let altitude: Double
    let climbingOrder: Int
}
