//
//  MountainRecordRequestModel.swift
//  orgo
//
//  Created by 김태현 on 2023/09/17.
//

import Foundation
import Alamofire

struct MountainRecordRequestModel {
    let mountainId: Int
    let latitude: Double
    let longitude: Double
    let altitude: Double
    let date: String
}

extension MountainRecordRequestModel {
    var parameter: Parameters {
        return [
            "mountainId": mountainId,
            "latitude": latitude,
            "longitude": longitude,
            "altitude": altitude,
            "date": date
        ]
    }
}
