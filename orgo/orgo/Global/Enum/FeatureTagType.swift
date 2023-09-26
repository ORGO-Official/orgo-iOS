//
//  FeatureTagType.swift
//  orgo
//
//  Created by 김태현 on 2023/09/26.
//

import UIKit

enum FeatureTagType: String {
    case totalCourse
    case gootNightView
    case parkingLot
    case restRoom
}

extension FeatureTagType {
    var title: String {
        switch self {
        case .totalCourse:
            return "코스"
        case .gootNightView:
            return "야경 맛집"
        case .parkingLot:
            return "주차장"
        case .restRoom:
            return "화장실"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .totalCourse:
            return ImageAssets.courseIcon
        case .gootNightView:
            return ImageAssets.nightViewIcon
        case .parkingLot:
            return ImageAssets.parkingIcon
        case .restRoom:
            return ImageAssets.toiletIcon
        }
    }
}
