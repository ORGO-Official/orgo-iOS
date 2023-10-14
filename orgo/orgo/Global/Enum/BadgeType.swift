//
//  BadgeType.swift
//  orgo
//
//  Created by 김태현 on 2023/10/14.
//

import UIKit

enum BadgeType: String, CaseIterable {
    case earlyBird = "Early Bird"
    
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
    
    var title: String {
        switch self {
        case .earlyBird:
            return "당신은 명예 초기 회원"
        case .meter500, .meter1000, .meter3000:
            return "누적 고도 \(self.rawValue) 달성"
        case .january, .february, .march, .april, .may, .june, .july, .august, .septeber, .october, .november, .december:
            return "\(self.rawValue)도 오르GO와 함께"
        case .acha, .inwang, .cheonggye, .bukhan, .gwanak, .yongma, .surak, .an, .dobong, .buram:
            return "\(self.rawValue) 정복 완료"
        }
    }

    var content: String {
        switch self {
        case .earlyBird: return "출시 1개월 이내 회원가입 시 얻을 수 있는 뱃지입니다!"
            
        case .meter500, .meter1000, .meter3000:
            return "총 고도 \(self.rawValue) 달성 시 얻을 수 있는 뱃지입니다!"
            
        case .january, .february, .march, .april, .may, .june, .july, .august, .septeber, .october, .november, .december:
            return "\(self.rawValue)에 완등을 성공하면 얻을 수 있는 뱃지입니다!"
            
        case .acha, .inwang, .cheonggye, .bukhan, .gwanak, .yongma, .surak, .an, .dobong, .buram:
            return "\(self.rawValue) 완등 1회 달성 시 얻을 수 있는 뱃지입니다!"
        }
    }
    
    var badgeImage: UIImage? {
        ImageAssets.earlyBirdBadge
    }
    
    var id: Int {
        switch self {
        case .acha: return 1
        case .inwang: return 4
        case .cheonggye: return 7
        case .bukhan: return 10
        case .gwanak: return 13
        case .yongma: return 16
        case .surak: return 19
        case .an: return 22
        case .dobong: return 25
        case .buram: return 28
        case .meter500: return 31
        case .meter1000: return 32
        case .meter3000: return 33
        case .septeber: return 34
        case .october: return 35
        case .november: return 36
        case .december: return 37
        default: return -1
        }
    }
    
}
