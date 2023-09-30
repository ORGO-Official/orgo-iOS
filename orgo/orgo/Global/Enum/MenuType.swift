//
//  MenuType.swift
//  orgo
//
//  Created by 김태현 on 2023/10/01.
//

import UIKit

enum MenuType {
    case photoSelect
    case share
}

extension MenuType {
    var upperTitle: String {
        switch self {
        case .photoSelect:
            return "갤러리에서 선택"
        case .share:
            return "Instagram으로 공유"
        }
    }
    
    var upperThumbnailImage: UIImage? {
        switch self {
        case .photoSelect:
            return ImageAssets.gallery
        case .share:
            return ImageAssets.instagram
        }
    }
    
    var lowerTitle: String {
        switch self {
        case .photoSelect:
            return "사진 촬영"
        case .share:
            return "카카오톡으로 공유"
        }
    }
    
    var lowerThumbnailImage: UIImage? {
        switch self {
        case .photoSelect:
            return ImageAssets.camera
        case .share:
            return ImageAssets.kakaoRound
        }
    }
}
