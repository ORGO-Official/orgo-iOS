//
//  BadgeCVC.swift
//  orgo
//
//  Created by 김태현 on 2023/10/14.
//

import UIKit

import SnapKit
import Then

import RxSwift
import RxGesture
import RxCocoa

class BadgeCVC: BaseCollectionViewCell {
    
    // MARK: - UI Components
    
    private let badgeImageView: UIImageView = UIImageView()
        .then {
            $0.image = ImageAssets.earlyBirdBadge
        }
    
    private let badgeTitle: UILabel = UILabel()
        .then {
            $0.font = .pretendard(size: 14.0, weight: .regular)
            $0.textColor = .white
            $0.textAlignment = .center
        }
    
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    
    override func configureView() {
        super.configureView()
        
        configureInnerView()
    }
    
    override func layoutView() {
        super.layoutView()
        
        configureLayout()
    }
    
    
    // MARK: - Methods
    
    func configureCell(with badge: Badge) {
        badgeImageView.image = badge.isAcquired ? badge.badgeImage : ImageAssets.defaultBadge
        badgeTitle.text = badge.name
    }
    
}


// MARK: - Configure

extension BadgeCVC {
    
    private func configureInnerView() {
        addSubviews([badgeImageView, badgeTitle])
    }
    
}


// MARK: - Layout

extension BadgeCVC {
    
    private func configureLayout() {
        badgeImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(badgeImageView.snp.width)
        }
        
        badgeTitle.snp.makeConstraints {
            $0.top.equalTo(badgeImageView.snp.bottom).offset(10.0)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
}
