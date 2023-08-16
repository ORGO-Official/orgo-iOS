//
//  MyPageVC.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit


class MyPageVC: BaseViewController {
    
    // MARK: - UI components
    
    let logoutBtn: UIButton = UIButton(type: .system)
        .then {
            $0.setTitle("로그아웃", for: .normal)
            $0.backgroundColor = .black
            $0.setTitleColor(.white, for: .normal)
        }
    
    let withdrawalBtn: UIButton = UIButton(type: .system)
        .then {
            $0.setTitle("회원탈퇴", for: .normal)
            $0.backgroundColor = .black
            $0.setTitleColor(.white, for: .normal)
        }
    
    
    
    // MARK: - Variables and Properties
    
    private let viewModel: MyPageVM = MyPageVM()
    
    
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

extension MyPageVC {
    
    private func configureInnerView() {
        view.addSubviews([logoutBtn, withdrawalBtn])
    }
    
}


// MARK: - Layout

extension MyPageVC {
    
    private func configureLayout() {
        logoutBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50.0)
            $0.bottom.equalToSuperview().offset(-100.0)
            $0.height.equalTo(50.0)
        }
        
        withdrawalBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50.0)
            $0.bottom.equalTo(logoutBtn.snp.top).offset(-10.0)
            $0.height.equalTo(50.0)
        }
    }
    
}


// MARK: - Input

extension MyPageVC {
    
    private func bindBtn() {
        logoutBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.viewModel.requestLogout()
            })
            .disposed(by: bag)
        
        withdrawalBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.viewModel.requestWithdrawal()
            })
            .disposed(by: bag)
    }
    
}
