//
//  TabBarItem.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import UIKit

enum TabBarItem: String {
    case home
    case myPage
}


// MARK: - CaseIterable

extension TabBarItem: CaseIterable {}


// MARK: - Icon Image

extension TabBarItem {
    
    var iconImage: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house")
        case .myPage:
            return UIImage(systemName: "person")
        }
    }
    
}


// MARK: - Custom Methods

extension TabBarItem {
    
    func createTabBarInnerVC() -> BaseViewController {
        switch self {
        case .home:
            return HomeVC()
        case .myPage:
            return MyPageVC()
        }
    }
    
}
