//
//  TabBarItem.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import UIKit

enum TabBarItem: String {
    case home
    case badge
    case myPage
}


// MARK: - CaseIterable

extension TabBarItem: CaseIterable {}


// MARK: - Icon Image

extension TabBarItem {
    
    var selectedImage: UIImage? {
        switch self {
        case .home:
            return ImageAssets.selectedHouse
        case .badge:
            return ImageAssets.selectedBadge
        case .myPage:
            return ImageAssets.selectedUser
        }
    }
    
    var unselectedImage: UIImage? {
        switch self {
        case .home:
            return ImageAssets.unselectedHouse
        case .badge:
            return ImageAssets.unselectedBadge
        case .myPage:
            return ImageAssets.unselectedUser
        }
    }
    
    var index: Int? {
        TabBarItem.allCases.firstIndex(of: self)
    }
    
}


// MARK: - Custom Methods

extension TabBarItem {
    
    func createTabBarInnerVC() -> BaseViewController {
        switch self {
        case .home:
            return HomeVC()
        case .badge:
            return BadgeListVC()
        case .myPage:
            return MyPageVC()
        }
    }
    
}
