//
//  MountainListResponseModel.swift
//  orgo
//
//  Created by 김태현 on 2023/08/18.
//

import Foundation

struct MountainListResponseModel: Codable {
    let id: Int
    let name: String
    let description: String
    let address: String
    let contact: String
    let difficulty: String
    let location: Location
    let featureTag: FeatureTag
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    let altitude: Double
}

struct FeatureTag: Codable {
    let goodNightView: Bool
    let totalCourse: Int
    let parkingLot: Bool
    let restRoom: Bool
    let cableCar: Bool
}
