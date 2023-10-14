//
//  BadgeCategory.swift
//  orgo
//
//  Created by 김태현 on 2023/10/14.
//

import Foundation

enum BadgeCategory: String, CaseIterable {
    case earlyBird = "나는야 얼리버드"
    case accumulatedAltitude = "진정한 등산왕"
    case monthly = "꾸준함이 생명"
    case completeMountain = "이곳저곳 오르GO"
}

extension BadgeCategory {
    
    static let earlyBirdBadge = [Badge(type: BadgeType.earlyBird)]
    static let accumulatedAltitudeBadges = [Badge(type: BadgeType.meter500),
                                            Badge(type: BadgeType.meter1000),
                                            Badge(type: BadgeType.meter3000)]
    static let montlyBadges = [Badge(type: BadgeType.january),
                               Badge(type: BadgeType.february),
                               Badge(type: BadgeType.march),
                               Badge(type: BadgeType.april),
                               Badge(type: BadgeType.may),
                               Badge(type: BadgeType.june),
                               Badge(type: BadgeType.july),
                               Badge(type: BadgeType.august),
                               Badge(type: BadgeType.septeber),
                               Badge(type: BadgeType.october),
                               Badge(type: BadgeType.november),
                               Badge(type: BadgeType.december)]
    static let completeMountainBadges = [Badge(type: BadgeType.acha),
                                         Badge(type: BadgeType.inwang),
                                         Badge(type: BadgeType.cheonggye),
                                         Badge(type: BadgeType.bukhan),
                                         Badge(type: BadgeType.gwanak),
                                         Badge(type: BadgeType.yongma),
                                         Badge(type: BadgeType.surak),
                                         Badge(type: BadgeType.an),
                                         Badge(type: BadgeType.dobong),
                                         Badge(type: BadgeType.buram)]

    var items: [Badge] {
        switch self {
        case .earlyBird: return BadgeCategory.earlyBirdBadge
        case .accumulatedAltitude: return BadgeCategory.accumulatedAltitudeBadges
        case .monthly: return BadgeCategory.montlyBadges
        case .completeMountain: return BadgeCategory.completeMountainBadges
        }
    }
    
}
