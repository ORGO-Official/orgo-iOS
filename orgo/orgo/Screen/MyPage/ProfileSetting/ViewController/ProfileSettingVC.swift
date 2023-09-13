//
//  ProfileSettingVC.swift
//  orgo
//
//  Created by 김태현 on 2023/09/07.
//

import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

class ProfileSettingVC: BaseViewController {
    
    // MARK: - UI components
    
    let headerView: UIView = UIView()
    
    let cancelBtn: UIButton = UIButton(type: .system)
        .then {
            $0.titleLabel?.font = UIFont.pretendard(size: 14.0, weight: .regular)
            $0.setTitle("취소", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .white
        }
    
    let headerLabel: UILabel = UILabel()
        .then {
            $0.text = "프로필 편집"
            $0.font = UIFont.pretendard(size: 14.0, weight: .medium)
            $0.textColor = .black
        }
    
    let confirmBtn: UIButton = UIButton(type: .system)
        .then {
            $0.titleLabel?.font = UIFont.pretendard(size: 15.0, weight: .regular)
            $0.setTitle("완료", for: .normal)
            $0.setTitleColor(.systemBlue, for: .normal)
            $0.backgroundColor = .white
        }
    
    let profileImageView: UIImageView = UIImageView()
        .then {
            $0.image = ImageAssets.mountainMarker
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 34.0
            $0.layer.masksToBounds = true
        }
    
    let changeProfileImageBtn: UIButton = UIButton(type: .system)
        .then {
            $0.titleLabel?.font = UIFont.pretendard(size: 13.0, weight: .regular)
            $0.setTitle("프로필 사진 수정", for: .normal)
            $0.setTitleColor(.systemBlue, for: .normal)
            $0.backgroundColor = .white
        }
    
    let profileImageBottomBorder: UIView = UIView()
        .then {
            $0.backgroundColor = ColorAssets.lightGray
        }
    
    let userNameTitle: UILabel = UILabel()
        .then {
            $0.text = "사용자 이름"
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
            $0.textColor = .black
        }
    
    let userNameTextField: UITextField = UITextField()
        .then {
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
            $0.textColor = .black
        }
    
    let accountTitle: UILabel = UILabel()
        .then {
            $0.text = "계정"
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
            $0.textColor = .black
        }
    
    let accountTextField: UITextField = UITextField()
        .then {
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
            $0.textColor = .black
        }
    
    let userNameBorder: UIView = UIView()
        .then {
            $0.backgroundColor = ColorAssets.lightGray
        }
    
    let accountBottomBorder: UIView = UIView()
        .then {
            $0.backgroundColor = ColorAssets.lightGray
        }
    
    
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
    
    override func bindInput() {
        super.bindInput()
        
        bindBtn()
    }
    
    // MARK: - Functions
    
}


// MARK: - Configure

extension ProfileSettingVC {
    
    private func configureInnerView() {
        view.addSubviews([headerView,
                          profileImageView,
                          changeProfileImageBtn,
                          profileImageBottomBorder,
                          userNameTitle,
                          userNameTextField,
                          accountTitle,
                          accountTextField,
                          userNameBorder,
                          accountBottomBorder])
        
        headerView.addSubviews([cancelBtn,
                                headerLabel,
                                confirmBtn])
    }
    
}


// MARK: - Layout

extension ProfileSettingVC {
    
    private func configureLayout() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48.0)
        }
        
        cancelBtn.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.0)
            $0.width.equalTo(cancelBtn.snp.height)
        }
        
        headerLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        confirmBtn.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.width.equalTo(confirmBtn.snp.height)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(40.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(profileImageView.layer.cornerRadius * 2)
        }
        
        changeProfileImageBtn.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120.0)
            $0.height.equalTo(30.0)
        }
        
        profileImageBottomBorder.snp.makeConstraints {
            $0.top.equalTo(changeProfileImageBtn.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1.0)
        }
        
        userNameTitle.snp.makeConstraints {
            $0.top.equalTo(profileImageBottomBorder.snp.bottom).offset(24.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.width.equalTo(72.0)
        }
        
        userNameTextField.snp.makeConstraints {
            $0.top.equalTo(userNameTitle)
            $0.leading.equalTo(userNameTitle.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.height.equalTo(16.0)
        }
        
        userNameBorder.snp.makeConstraints {
            $0.top.equalTo(userNameTextField.snp.bottom).offset(24.0)
            $0.leading.equalTo(userNameTextField.snp.leading)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(1.0)
        }
        
        accountTitle.snp.makeConstraints {
            $0.top.equalTo(userNameBorder.snp.bottom).offset(24.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.width.equalTo(72.0)
        }
        
        accountTextField.snp.makeConstraints {
            $0.top.equalTo(accountTitle)
            $0.leading.trailing.equalTo(userNameTextField)
            $0.height.equalTo(16.0)
        }
        
        accountBottomBorder.snp.makeConstraints {
            $0.top.equalTo(accountTitle.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1.0)
        }
    }
    
}


// MARK: - Input

extension ProfileSettingVC {
    
    private func bindBtn() {
        cancelBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.dismiss(animated: true)
            })
            .disposed(by: bag)
        
        confirmBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                print("TODO: - 프로필 수정 API 호출")
            })
            .disposed(by: bag)
        
        changeProfileImageBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                print("TODO: - 프로필 사진 수정")
            })
            .disposed(by: bag)
    }
    
}
