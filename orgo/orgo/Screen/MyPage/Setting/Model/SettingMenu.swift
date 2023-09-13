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


extension SettingMenu {
    var urlString: String {
        switch self {
        case .privacyPolicy:
            return "https://orgo-offical.notion.site/2b4924eb179d48c8a48793d45c13f831?pvs=4"
        case .servicePolicy:
            return "https://orgo-offical.notion.site/e4fd74248ca04a8096ac209be33d5464?pvs=4"
        default:
            return .empty
        }
    }
}
