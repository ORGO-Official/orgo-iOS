//
//  IconInfoView.swift
//  orgo
//
//  Created by 김태현 on 2023/09/15.
//

import UIKit

import SnapKit
import Then

class IconInfoView: BaseView {
    
    // MARK: - UI components
    
    let iconStackView: UIStackView = UIStackView()
        .then {
            $0.spacing = 6.0
            $0.distribution = .fillEqually
            $0.alignment = .center
            $0.axis = .horizontal
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
    
    func configureIcon(by data: MountainListResponseModel) {
        
    }
    
}


// MARK: - Configure

extension IconInfoView {
    
    private func configureInnerView() {
        addSubviews([iconStackView])
    }
    
}


// MARK: - Layout

extension IconInfoView {
    
    private func configureLayout() {
        iconStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
