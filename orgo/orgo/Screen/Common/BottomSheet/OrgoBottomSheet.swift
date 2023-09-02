//
//  OrgoBottomSheet.swift
//  orgo
//
//  Created by 김태현 on 2023/08/18.
//

import UIKit

import RxSwift
import RxGesture

import Then
import SnapKit

class OrgoBottomSheet: BaseViewController {
    
    // MARK: - UI components
    
    let dimmedView = UIView()
        .then {
            $0.backgroundColor = .black.withAlphaComponent(0.2)
        }
    
    let bottomSheetView = UIView()
        .then {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 16.0
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.clipsToBounds = true
        }
    
    let sheetBar = UIView()
        .then {
            $0.layer.cornerRadius = 1.5
            $0.layer.masksToBounds = true
            $0.backgroundColor = .lightGray
            $0.isUserInteractionEnabled = false
        }
    
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
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
        
        bindDimmedView()
    }
    
    // MARK: - Functions
    
    func showBottomSheet() {
        bottomSheetView.snp.updateConstraints {
            $0.height.equalTo(280.0)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.dimmedView.alpha = 0.8
            
            self.view.layoutIfNeeded()
        }
    }
    
    func dismissBottomSheet() {
        bottomSheetView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let self = self else { return }
            
            if self.presentingViewController != nil {
                self.dismiss(animated: false)
            }
        }
    }
    
}


// MARK: - Configure

extension OrgoBottomSheet {
    
    private func configureInnerView() {
        view.backgroundColor = .clear
        
        view.addSubviews([dimmedView, bottomSheetView])
        bottomSheetView.addSubview(sheetBar)
        dimmedView.alpha = 0.0
        
        configureShadow()
    }
    
    private func configureShadow() {
        view.layer.shadowColor = CGColor(red: 23.0 / 255.0, green: 23.0 / 255.0, blue: 23.0 / 255.0, alpha: 1)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 16.0
        view.layer.shadowOffset = CGSize(width: 0, height: -4.0)
        view.layer.masksToBounds = false
    }
    
}


// MARK: - Layout

extension OrgoBottomSheet {
    
    private func configureLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        sheetBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(8)
            $0.width.equalTo(32)
            $0.height.equalTo(sheetBar.layer.cornerRadius * 2.0)
        }
    }
    
}


// MARK: - Input

extension OrgoBottomSheet {
    
    private func bindDimmedView() {
        dimmedView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.dismissBottomSheet()
            })
            .disposed(by: bag)
    }
    
}
