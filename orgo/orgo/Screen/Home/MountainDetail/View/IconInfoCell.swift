//
//  IconInfoView.swift
//  orgo
//
//  Created by 김태현 on 2023/09/15.
//

import UIKit

import SnapKit
import Then

class IconInfoCell: BaseView {
    
    // MARK: - UI components
    
    let iconImageView: UIImageView = UIImageView()
        .then {
            $0.contentMode = .scaleAspectFit
        }
    
    let iconTitleLabel: UILabel = UILabel()
        .then {
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
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
    
    func configureIcon(image: UIImage?, title: String) {
        iconImageView.image = image
        iconTitleLabel.text = title
    }
    
}


// MARK: - Configure

extension IconInfoCell {
    
    private func configureInnerView() {
        addSubviews([iconImageView,
                     iconTitleLabel])
    }
    
}


// MARK: - Layout

extension IconInfoCell {
    
    private func configureLayout() {
        iconImageView.snp.makeConstraints {
            $0.centerX.top.equalToSuperview()
            $0.bottom.equalTo(iconTitleLabel.snp.top).offset(-8.0)
            $0.width.equalTo(iconImageView.snp.height)
        }
        
        iconTitleLabel.snp.makeConstraints {
            $0.centerX.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(12.0)
        }
    }
    
}
