//
//  TabBarView.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import Foundation

import Then
import SnapKit

class TabBarView: BaseView {
    
    // MARK: - UI components
    
    /// 탭 바 버튼 들어가는 스택뷰
    let stackView = UIStackView()
        .then {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.spacing = .zero
        }
    
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
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

extension TabBarView {
    
    private func configureInnerView() {
        addSubviews([stackView])
        
        backgroundColor = .white
    }
    
}

// MARK: - Layout

extension TabBarView {
    
    private func configureLayout() {
        stackView.snp.makeConstraints {
            $0.height.equalTo(50.0)
            $0.top.horizontalEdges.equalTo(self)
        }
    }
    
}
