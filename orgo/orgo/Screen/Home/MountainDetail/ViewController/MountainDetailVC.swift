//
//  MountainDetailVC.swift
//  orgo
//
//  Created by 김태현 on 2023/08/21.
//

import Foundation

import RxSwift
import RxCocoa

import Then
import SnapKit

class MountainDetailVC: BaseNavigationViewController {
    
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

extension MountainDetailVC {
    
    private func configureInnerView() {
        title = "산 상세 페이지"
        navigationBar.style = .left
        
    }
    
}


// MARK: - Layout

extension MountainDetailVC {
    
    private func configureLayout() {
        
    }
    
}
