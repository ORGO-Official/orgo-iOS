//
//  LoginVC.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit


class LoginVC: BaseViewController {
    
    // MARK: - UI components
    
    private let logoImageView = UIImageView(image: ImageAssets.orgoLogoGreen)
    
    private let stackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 12.0
        }
    
    private let kakaoLoginBtn = UIButton(type: .system)
        .then {
            $0.setImage(ImageAssets.kakaoLogin, for: .normal)
        }
    
    private let naverLoginBtn = UIButton(type: .system)
        .then {
            $0.setImage(ImageAssets.naverLogin, for: .normal)
        }
    
    private let appleLoginBtn = UIButton(type: .system)
        .then {
            $0.setImage(ImageAssets.appleLogin, for: .normal)
        }
    
    private let loginBorder = UIImageView(image: ImageAssets.loginBorder)
    
    private let loginNextBtn = UIButton(type: .system)
        .then {
            $0.setImage(ImageAssets.loginNext, for: .normal)
        }
    
    
    // MARK: - Variables and Properties
    
    private let viewModel: LoginVM = LoginVM()
    
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

extension LoginVC {
    
    private func configureInnerView() {
        view.addSubviews([logoImageView, stackView])
        [kakaoLoginBtn, naverLoginBtn, appleLoginBtn, loginBorder, loginNextBtn].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
}


// MARK: - Layout

extension LoginVC {
    
    private func configureLayout() {
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(140.0)
            $0.height.equalTo(logoImageView.snp.width).dividedBy(2.43)
            $0.top.equalToSuperview().offset(200.0)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom).offset(110.0)
            $0.trailing.leading.equalToSuperview().inset(50.0)
        }
        
        [kakaoLoginBtn, naverLoginBtn, appleLoginBtn, loginNextBtn].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(stackView.snp.width).dividedBy(5.62)
            }
        }
        
        loginBorder.snp.makeConstraints {
            $0.height.equalTo(stackView.snp.width).dividedBy(19.13)
        }
    }
    
}


// MARK: - Input

extension LoginVC {
    
    private func bindBtn() {
        kakaoLoginBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.viewModel.requestKakaoLogin()
            })
            .disposed(by: bag)
    }
    
}
