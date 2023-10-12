//
//  BadgeListVC.swift
//  orgo
//
//  Created by 김태현 on 2023/10/13.
//

import Foundation

import RxSwift
import RxCocoa
import RxGesture

import Then
import SnapKit

final class BadgeListVC: BaseViewController {
    
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

extension BadgeListVC {
    
    private func configureInnerView() {
        view.backgroundColor = ColorAssets.mainGreen
        
    }
    
}


// MARK: - Layout

extension BadgeListVC {
    
    private func configureLayout() {
        
    }
    
}
