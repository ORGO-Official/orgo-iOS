//
//  BadgeBottomSheetVC.swift
//  orgo
//
//  Created by 김태현 on 2023/10/15.
//

import UIKit

import SnapKit
import Then

import RxSwift
import RxGesture
import RxCocoa

class BadgeBottomSheetVC: OrgoBottomSheet {
    
    // MARK: - UI Components
    
    private let badgeImageView: UIImageView = UIImageView()
    
    private let badgeTitleLabel: UILabel = UILabel()
        .then {
            $0.font = .pretendard(size: 15.0, weight: .medium)
            $0.textColor = .label
            $0.textAlignment = .center
        }
    
    private let badgeContentLabel: UILabel = UILabel()
        .then {
            $0.font = .pretendard(size: 14.0, weight: .regular)
            $0.textColor = .label
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
    
    
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
        
        configureBottomSheetLayout()
    }
    
    
    // MARK: - Methods
    
    func configureBottomSheet(by badge: Badge) {
        badgeImageView.image = badge.badgeImage
        badgeTitleLabel.text = badge.name
        badgeContentLabel.text = badge.content
    }
    
}


// MARK: - Configure

extension BadgeBottomSheetVC {
    
    private func configureInnerView() {
        view.addSubviews([badgeImageView,
                          badgeTitleLabel,
                          badgeContentLabel])
    }
    
}


// MARK: - Layout

extension BadgeBottomSheetVC {
    
    private func configureBottomSheetLayout() {
        badgeImageView.snp.makeConstraints {
            $0.top.equalTo(bottomSheetView.snp.top).offset(36.0)
            $0.centerX.equalTo(bottomSheetView.snp.centerX)
            $0.height.width.equalTo(120.0)
        }
        
        badgeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(badgeImageView.snp.bottom).offset(24.0)
            $0.centerX.equalTo(bottomSheetView.snp.centerX)
        }
        
        badgeContentLabel.snp.makeConstraints {
            $0.top.equalTo(badgeTitleLabel.snp.bottom).offset(19.0)
            $0.leading.trailing.equalTo(bottomSheetView).inset(44.0)
        }
    }
    
}
