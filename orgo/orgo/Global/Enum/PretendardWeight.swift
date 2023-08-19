//
//  PretendardWeight.swift
//  orgo
//
//  Created by 김태현 on 2023/08/19.
//

import Foundation

enum PretendardWeight: String {
    case bold = "Bold"
    case semibold = "SemiBold"
    case medium = "Medium"
    case regular = "Regular"
}

extension PretendardWeight {
    
    func fontName() -> String {
        return "Pretendard-\(self.rawValue)"
    }
    
}
