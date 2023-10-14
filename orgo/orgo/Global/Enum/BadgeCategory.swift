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
    
    var items: [Badge] {
        switch self {
        case .earlyBird:
            return [BadgeType.earlyBird.badge]
        case .accumulatedAltitude:
            return [BadgeType.meter500.badge,
                    BadgeType.meter1000.badge,
                    BadgeType.meter3000.badge]
        case .monthly:
            return [BadgeType.january.badge,
                    BadgeType.february.badge,
                    BadgeType.march.badge,
                    BadgeType.april.badge,
                    BadgeType.may.badge,
                    BadgeType.june.badge,
                    BadgeType.july.badge,
                    BadgeType.august.badge,
                    BadgeType.septeber.badge,
                    BadgeType.october.badge,
                    BadgeType.november.badge,
                    BadgeType.december.badge]
        case .completeMountain:
            return [BadgeType.acha.badge,
                    BadgeType.inwang.badge,
                    BadgeType.cheonggye.badge,
                    BadgeType.bukhan.badge,
                    BadgeType.gwanak.badge,
                    BadgeType.yongma.badge,
                    BadgeType.surak.badge,
                    BadgeType.an.badge,
                    BadgeType.dobong.badge,
                    BadgeType.buram.badge,]
        }
    }
}
