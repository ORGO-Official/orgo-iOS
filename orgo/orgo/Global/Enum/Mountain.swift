//
//  Mountain.swift
//  orgo
//
//  Created by 김태현 on 2023/10/13.
//

import Foundation

enum Mountain: String {
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

extension Mountain {
    var englishName: String {
        switch self {
        case .acha: return "Acha"
        case .inwang: return "Inwang"
        case .cheonggye: return "Cheonggye"
        case .bukhan: return "Bukhan"
        case .gwanak: return "Gwanak"
        case .yongma: return "Yongma"
        case .surak: return "Surak"
        case .an: return "An"
        case .dobong: return "Dobong"
        case .buram: return "Buram"
        }
    }
}
