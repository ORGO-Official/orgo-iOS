//
//  SettingVC.swift
//  orgo
//
//  Created by 김태현 on 2023/09/07.
//

import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

class SettingVC: BaseNavigationViewController {
    
    // MARK: - UI components
    
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        super.configureView()
        
        configureInnerView()
    }
    
    override func layoutView() {
        super.layoutView()
        
        configureLayout()
    }
    
    // MARK: - Functions
    
}


// MARK: - Configure

extension SettingVC {
    
    private func configureInnerView() {
        title = "설정"
        navigationBar.style = .left
    }
    
}


// MARK: - Layout

extension SettingVC {
    
    private func configureLayout() {
        
    }
    
}
