//
//  LoginType.swift
//  orgo
//
//  Created by 김태현 on 2023/08/16.
//

import Foundation

enum LoginType: String {
    case kakao
    case naver
    case apple
}


// MARK: - Custom String Convertible

extension LoginType: CustomStringConvertible {
    var description: String {
        rawValue.localized
    }
}
