//
//  UserInfoView.swift
//  orgo
//
//  Created by 김태현 on 2023/09/07.
//

import UIKit

import SnapKit
import Then

class UserInfoView: BaseView {
    
    // MARK: - UI components
    
    let userNameLabel: UILabel = UILabel()
        .then {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 20.0, weight: .bold)
        }
    
    let profileSettingBtn: UIButton = UIButton(type: .system)
        .then {
            $0.titleLabel?.font = UIFont.pretendard(size: 13.0, weight: .regular)
            $0.setTitle("프로필 관리", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            
            $0.setBackgroundColor(.white, for: .normal)
            
            $0.layer.borderColor = ColorAssets.lightGray.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 10.0
            $0.layer.masksToBounds = true
        }
    
    let settingBtn: UIButton = UIButton(type: .system)
        .then {
            $0.setImage(ImageAssets.setting, for: .normal)
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

extension UserInfoView {
    
    private func configureInnerView() {
        addSubviews([userNameLabel,
                     profileSettingBtn,
                     settingBtn])
        
        userNameLabel.text = "TEST"
    }
    
}


// MARK: - Layout

extension UserInfoView {
    
    private func configureLayout() {
        userNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(8.0)
            $0.height.equalTo(20.0)
        }
        
        profileSettingBtn.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(userNameLabel.snp.trailing).offset(12.0)
            $0.height.equalTo(20.0)
            $0.width.equalTo(110.0)
        }
        
        settingBtn.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.height.width.equalTo(24.0)
        }
    }
    
}
