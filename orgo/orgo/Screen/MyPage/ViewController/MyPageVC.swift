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
    
    let userInfoView: UserInfoView = UserInfoView()
    
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
    
    override func bindOutput() {
        super.bindOutput()
        
        bindLogoutSuccess()
    }
    
    // MARK: - Functions
    
}


// MARK: - Configure

extension MyPageVC {
    
    private func configureInnerView() {
        view.addSubviews([userInfoView,
                          logoutBtn,
                          withdrawalBtn])
    }
    
}


// MARK: - Layout

extension MyPageVC {
    
    private func configureLayout() {
        userInfoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(160.0)
        }
        
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


// MARK: - Output

extension MyPageVC {
    
    /// 로그아우 성공 감지
    private func bindLogoutSuccess() {
        viewModel.output.isLogoutSuccess
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isLogoutSuccess in
                guard let self = self else { return }
                
                if isLogoutSuccess {
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVCToLogin()
                } else {
                    self.showErrorAlert("로그아웃 실패")
                }
            })
            .disposed(by: bag)
        
        viewModel.output.isWithdrawalSuccess
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isWithdrawalSuccess in
                guard let self = self else { return }
                
                if isWithdrawalSuccess {
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVCToLogin()
                } else {
                    self.showErrorAlert("회원탈퇴 실패")
                }
            })
            .disposed(by: bag)
    }
    
}
