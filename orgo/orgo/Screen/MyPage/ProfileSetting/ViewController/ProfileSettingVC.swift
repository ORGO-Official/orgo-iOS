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
        view.addSubviews([headerView])
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
    }
    
}
