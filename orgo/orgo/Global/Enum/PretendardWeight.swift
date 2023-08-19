//
//  PretendardWeight.swift
//  orgo
//
//  Created by 김태현 on 2023/08/19.
//

import Foundation

enum PretendardWeight: String {
    case bold
    case semibold
    case medium
    case regular
}

extension PretendardWeight {
    
    func fontName() -> String {
        "Pretendard-\(rawValue.capitalized)"
    }
    
}
