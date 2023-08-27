//
//  RestaurantListResponseModel.swift
//  orgo
//
//  Created by 김태현 on 2023/08/28.
//

import Foundation

struct RestaurantListResponseModel: Codable {
    let name: String
    let address: String
    let distance: Double
    let mapX: Double
    let mapY: Double
    let contact: String
    let imageUrl: String
    let externalLink: String
}
