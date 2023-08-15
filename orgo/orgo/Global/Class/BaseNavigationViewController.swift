//
//  BaseNavigationViewController.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

class BaseNavigationViewController: BaseViewController {
    
    // MARK: - UI components
    
    var navigationBar: NavigationBar!
    
    var navigationBarStyle: NavigationBarStyle {
        .default
    }
    
    
    // MARK: - Variables and Properties
    
    override var title: String? {
        didSet {
            navigationBar.titleLabel.text = title
        }
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
        
        configureLayout()
    }
    
    override func bindInput() {
        super.bindInput()
        
        bindBtn()
    }
    
    
    // MARK: - Functions
    
    func backBtnPressed() {
        guard let navC = navigationController else {
            dismiss(animated: true)
            return
        }
        
        navC.popViewController(animated: true)
    }
    
}


// MARK: - Configure

extension BaseNavigationViewController {
    
    private func configureInnerView() {
        navigationBar = NavigationBar(style: navigationBarStyle, title: title)
        
        view.addSubview(navigationBar)
    }
    
}


// MARK: - Layout

extension BaseNavigationViewController {
    
    private func configureLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        navigationBar.titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}


// MARK: - Input

extension BaseNavigationViewController {
    
    private func bindBtn() {
        navigationBar.leftBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.backBtnPressed()
            })
            .disposed(by: bag)
        
        navigationBar.rightBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.backBtnPressed()
            })
            .disposed(by: bag)
    }
    
}
