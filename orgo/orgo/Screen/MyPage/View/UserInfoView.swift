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
    
    let profileImageView: UIImageView = UIImageView()
        .then {
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 34.0
            $0.layer.masksToBounds = true
        }
    
    let totalHeightTitle: UILabel = UILabel()
        .then {
            $0.text = "총 고도"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
        }
    
    let totalHeightLabel: UILabel = UILabel()
        .then {
            $0.textColor = ColorAssets.gray
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(size: 13.0, weight: .regular)
        }
    
    let totalCountTitle: UILabel = UILabel()
        .then {
            $0.text = "완등 횟수"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
        }
    
    let totalCountLabel: UILabel = UILabel()
        .then {
            $0.textColor = ColorAssets.gray
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(size: 13.0, weight: .regular)
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
    
    /// 총 고도, 완등 횟수 설정
    func setTotalRecord(altitude: Double, count: Int) {
        totalHeightLabel.text = "\(Int(altitude))m"
        totalCountLabel.text = "\(count)회"
    }
    
    /// 유저 정보 설정
    func setUserInfo(data: UserInfoResponseModel) {
        userNameLabel.text = data.nickname
        profileImageView.setImage(with: data.profileImage)
    }
    
}


// MARK: - Configure

extension UserInfoView {
    
    private func configureInnerView() {
        addSubviews([userNameLabel,
                     profileSettingBtn,
                     settingBtn,
                     profileImageView,
                     totalHeightTitle,
                     totalHeightLabel,
                     totalCountTitle,
                     totalCountLabel])
        
        userNameLabel.text = "TEST"
    }
    
}


// MARK: - Layout

extension UserInfoView {
    
    private func configureLayout() {
        userNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(8.0)
            $0.height.equalTo(24.0)
        }
        
        profileSettingBtn.snp.makeConstraints {
            $0.centerY.equalTo(userNameLabel)
            $0.leading.equalTo(userNameLabel.snp.trailing).offset(12.0)
            $0.height.equalTo(20.0)
            $0.width.equalTo(110.0)
        }
        
        settingBtn.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.height.width.equalTo(24.0)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(20.0)
            $0.leading.equalToSuperview().offset(8.0)
            $0.height.width.equalTo(profileImageView.layer.cornerRadius * 2)
        }
        
        totalHeightTitle.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(58.0)
            $0.bottom.equalTo(profileImageView.snp.centerY)
        }
        
        totalHeightLabel.snp.makeConstraints {
            $0.centerX.equalTo(totalHeightTitle.snp.centerX)
            $0.top.equalTo(totalHeightTitle.snp.bottom).offset(8.0)
        }
        
        totalCountTitle.snp.makeConstraints {
            $0.centerY.equalTo(totalHeightTitle.snp.centerY)
            $0.leading.equalTo(totalHeightTitle.snp.trailing).offset(58.0)
        }
        
        totalCountLabel.snp.makeConstraints {
            $0.centerX.equalTo(totalCountTitle.snp.centerX)
            $0.top.equalTo(totalCountTitle.snp.bottom).offset(8.0)
        }
        
    }
    
}
