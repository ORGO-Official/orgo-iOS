//
//  PopUpType.swift
//  orgo
//
//  Created by 김태현 on 2023/09/24.
//

import Foundation

enum PopUpType {
    case logout
    case withdrawal
}

extension PopUpType {
    var title: String {
        switch self {
        case .logout:
            return "정말 로그아웃 하시겠어요?"
        case .withdrawal:
            return "정말 회원탈퇴 하시겠어요?"
        }
    }
    
    var desc: String {
        switch self {
        case .logout:
            return "로그아웃 시에도\n오르고 서비스는 계속 이용 가능합니다."
        case .withdrawal:
            return "회원탈퇴시 모든 정보가 사라집니다."
        }
    }
    
    var confirmTitle: String {
        switch self {
        case .logout, .withdrawal:
            return "예"
        }
    }
    
    var cancelTitle: String {
        switch self {
        case .logout, .withdrawal:
            return "아니오"
        }
    }
}
