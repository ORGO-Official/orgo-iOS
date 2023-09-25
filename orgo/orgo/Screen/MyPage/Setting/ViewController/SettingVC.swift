//
//  SettingVC.swift
//  orgo
//
//  Created by 김태현 on 2023/09/07.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

import Then
import SnapKit

import SafariServices

class SettingVC: BaseNavigationViewController {
    
    // MARK: - UI components
    
    let settingMenuTV: UITableView = UITableView()
        .then {
            $0.rowHeight = 52.0
            $0.backgroundColor = .white
            $0.showsVerticalScrollIndicator = false
            $0.separatorStyle = .none
            $0.register(SettingMenuTVC.self, forCellReuseIdentifier: SettingMenuTVC.className)
        }
    
    
    // MARK: - Variables and Properties
    
    private let viewModel = SettingVM()
    
    
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
        
        bindMenuSelected()
    }
    
    override func bindOutput() {
        super.bindOutput()
        
        bindSettingMenuTV()
        bindLogoutSuccess()
        bindWithdrawalSuccess()
    }
    
    // MARK: - Functions
    
    @objc func signout() {
        viewModel.requestLogout()
    }
    
    @objc func withdrawal() {
        viewModel.requestWithdrawal()
    }
    
}


// MARK: - Configure

extension SettingVC {
    
    private func configureInnerView() {
        title = "설정"
        navigationBar.style = .left
        
        view.addSubviews([settingMenuTV])
    }
    
}


// MARK: - Layout

extension SettingVC {
    
    private func configureLayout() {
        settingMenuTV.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}


// MARK: - Input

extension SettingVC {
    
    private func bindMenuSelected() {
        settingMenuTV.rx.modelSelected(SettingMenu.self)
            .withUnretained(self)
            .bind(onNext: { owner, menu in
                switch menu {
                case .privacyPolicy, .servicePolicy:
                    guard let url = URL(string: menu.urlString) else { return }
                    let safariVC = SFSafariViewController(url: url)
                    safariVC.preferredBarTintColor = .white
                    safariVC.preferredControlTintColor = .black
                    
                    owner.present(safariVC, animated: true)
                case .signout:
                    owner.showPopUp(type: .logout, targetVC: owner, confirmAction: #selector(owner.signout))
                case .withdrawal:
                    owner.showPopUp(type: .withdrawal, targetVC: owner, confirmAction: #selector(owner.withdrawal))
                }
            })
            .disposed(by: bag)
        
        settingMenuTV.rx.itemSelected
            .withUnretained(self)
            .bind(onNext: { owner, indexPath in
                owner.settingMenuTV.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: bag)
    }
    
}

// MARK: - Output

extension SettingVC {
    
    private func bindSettingMenuTV() {
        let dataSource = RxTableViewSectionedReloadDataSource<SettingMenuDataSource> { _,
            tableView,
            indexPath,
            menu in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingMenuTVC.className,
                                                           for: indexPath) as? SettingMenuTVC else {
                fatalError("Cannot dequeue Cell")
            }
            
            cell.configureMenu(menuType: menu)
            
            return cell
        }
        
        viewModel.output.settingMenuDataSource
            .bind(to: settingMenuTV.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
    /// 로그아웃 성공 감지
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
    }
    
    /// 회원탈퇴 성공 감지
    private func bindWithdrawalSuccess() {
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
