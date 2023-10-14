//
//  Badge.swift
//  orgo
//
//  Created by 김태현 on 2023/10/14.
//

import UIKit

struct Badge {
    let type: BadgeType
    let name: String
    let content: String
    let badgeImage: UIImage?
    var isAcquired: Bool = false
    
    init(type: BadgeType) {
        self.type = type
        self.name = type.rawValue
        self.content = type.content
        self.badgeImage = type.badgeImage
    }
}
