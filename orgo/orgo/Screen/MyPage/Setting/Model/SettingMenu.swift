//
//  SettingMenu.swift
//  orgo
//
//  Created by 김태현 on 2023/09/12.
//

import Foundation

enum SettingMenu: String {
    case privacyPolicy = "개인정보처리방침"
    case servicePolicy = "이용약관"
    case signout = "로그아웃"
    case withdrawal = "회원탈퇴"
    
    static let unAuthenticated = [
        SettingMenu.privacyPolicy,
        SettingMenu.servicePolicy
    ]
    
    static let authenticated = [
        SettingMenu.privacyPolicy,
        SettingMenu.servicePolicy,
        SettingMenu.signout,
        SettingMenu.withdrawal
    ]
}


extension SettingMenu: CustomStringConvertible {
    var description: String {
        rawValue.localized
    }
}
