//
//  BadgeType.swift
//  orgo
//
//  Created by 김태현 on 2023/10/14.
//

import Foundation

enum BadgeType: String, CaseIterable {
    case earlyBird
    
    case meter500 = "500m"
    case meter1000 = "1000m"
    case meter3000 = "3000m"
    
    case january = "1월"
    case february = "2월"
    case march = "3월"
    case april = "4월"
    case may = "5월"
    case june = "6월"
    case july = "7월"
    case august = "8월"
    case septeber = "9월"
    case october = "10월"
    case november = "11월"
    case december = "12월"
    
    case acha = "아차산"
    case inwang = "인왕산"
    case cheonggye = "청계산"
    case bukhan = "북한산"
    case gwanak = "관악산"
    case yongma = "용마산"
    case surak = "수락산"
    case an = "안산"
    case dobong = "도봉산"
    case buram = "불암산"
}

extension BadgeType {
    
    var badge: Badge {
        Badge(type: self)
    }
    
}
