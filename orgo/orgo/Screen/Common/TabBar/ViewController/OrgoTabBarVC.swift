//
//  OrgoTabBarVC.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import Foundation

import RxSwift
import RxCocoa

import Then
import SnapKit

class OrgoTabBarVC: BaseViewController {
    
    // MARK: - UI components
    
    private let tabBarView: TabBarView = TabBarView()
    
    
    // MARK: - Variables and Properties
    
    private let tabBarItems: [TabBarItem] = TabBarItem.allCases
    private let vcList: [BaseNavigationController] = []
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        super.configureView()
        
    }
    
    override func layoutView() {
        super.layoutView()
        
    }
    
    // MARK: - Functions
    
}
