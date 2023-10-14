//
//  BadgeHeaderView.swift
//  orgo
//
//  Created by 김태현 on 2023/10/14.
//

import UIKit

import Then
import SnapKit

class BadgeHeaderView: UICollectionReusableView {
    
    // MARK: - UI components
    
    private let titleLabel = UILabel()
        .then {
            $0.textColor = .white
            $0.font = .pretendard(size: 14.0, weight: .regular)
            $0.textAlignment = .center
        }
    
    private let leftBorderLine = UIView()
        .then {
            $0.backgroundColor = .white
        }
    
    private let rightBorderLine = UIView()
        .then {
            $0.backgroundColor = .white
        }
    
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureInnerView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Methods
    
    func setHeader(title: String) {
        titleLabel.text = title
    }
    
}

// MARK: - Configure

extension BadgeHeaderView {
    
    private func configureInnerView() {
        addSubviews([titleLabel,
                     leftBorderLine,
                     rightBorderLine])
    }
    
}


// MARK: - Layout

extension BadgeHeaderView {
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        leftBorderLine.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(13.0)
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalTo(titleLabel.snp.leading).offset(-8.0)
            $0.height.equalTo(1.0)
        }
        
        rightBorderLine.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-13.0)
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8.0)
            $0.height.equalTo(1.0)
        }
    }
    
}
