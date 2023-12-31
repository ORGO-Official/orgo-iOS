//
//  OrgoPopUpVC.swift
//  orgo
//
//  Created by 김태현 on 2023/09/24.
//

import UIKit

import SnapKit
import Then

import RxSwift
import RxCocoa
import RxGesture


class OrgoPopUpVC: BaseViewController {
    
    // MARK: - UI components
    
    private let dimmedView: UIView = UIView()
        .then {
            $0.backgroundColor = .black.withAlphaComponent(0.2)
        }
    
    private let contentView: UIView = UIView()
        .then {
            $0.layer.cornerRadius = 5.0
            $0.backgroundColor = .white
        }
    
    private let descView: UIView = UIView()
    
    private let descStackView: UIStackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.spacing = 4.0
            $0.alignment = .fill
            $0.distribution = .fill
        }
    
    private let titleLabel: UILabel = UILabel()
        .then {
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(size: 14.0, weight: .medium)
            $0.textColor = .black
        }
    
    private let descLabel: UILabel = UILabel()
        .then {
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
            $0.textColor = ColorAssets.gray
            $0.numberOfLines = 0
        }
    
    private let btnStackView: UIStackView = UIStackView()
        .then {
            $0.axis = .horizontal
            $0.spacing = 10.0
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
    
    private let confirmBtn: UIButton = UIButton(type: .system)
        .then {
            $0.setTitleColor(.black, for: .normal)
            $0.setBackgroundColor(ColorAssets.lightGray, for: .normal)
            $0.setBackgroundColor(ColorAssets.buttonSelectedBlue, for: .highlighted)
            $0.layer.cornerRadius = 5.0
        }
    
    private let cancelBtn: UIButton = UIButton(type: .system)
        .then {
            $0.tintColor = .clear
            $0.setTitleColor(.black, for: .normal)
            $0.setBackgroundColor(ColorAssets.lightGray, for: .normal)
            $0.setBackgroundColor(ColorAssets.buttonSelectedBlue, for: .highlighted)
            $0.layer.cornerRadius = 5.0
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
        
        bindTap()
    }
    
    // MARK: - Functions
    
    func configurePopUp(type: PopUpType, targetVC: UIViewController, confirmAction: Selector) {
        titleLabel.text = type.title
        descLabel.text = type.desc
        
        confirmBtn.setTitle(type.confirmTitle, for: .normal)
        cancelBtn.setTitle(type.cancelTitle, for: .normal)
        
        confirmBtn.addTarget(targetVC, action: confirmAction, for: .touchUpInside)
    }
    
}


// MARK: - Configure

extension OrgoPopUpVC {
    
    private func configureInnerView() {
        view.addSubviews([dimmedView,
                          contentView])
        
        view.backgroundColor = .clear
        
        contentView.addSubviews([descView, btnStackView])
        
        descView.addSubviews([descStackView])
        
        [titleLabel, descLabel].forEach {
            descStackView.addArrangedSubview($0)
        }
        
        [confirmBtn, cancelBtn].forEach {
            btnStackView.addArrangedSubview($0)
        }
    }
    
}


// MARK: - Layout

extension OrgoPopUpVC {
    
    private func configureLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(contentView.snp.width).dividedBy(2.0)
        }
        
        descView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(btnStackView.snp.top)
        }
        
        descStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(40.0)
        }
        
        btnStackView.snp.makeConstraints {
            $0.height.equalTo(contentView.snp.height).dividedBy(5.2)
            $0.leading.bottom.trailing.equalToSuperview().inset(16.0)
        }
    }
    
}


// MARK: - Input

extension OrgoPopUpVC {
    
    private func bindTap() {
        dimmedView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.dismiss(animated: false)
            })
            .disposed(by: bag)
        
        cancelBtn.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.dismiss(animated: false)
            })
            .disposed(by: bag)
        
        confirmBtn.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.dismiss(animated: false)
            })
            .disposed(by: bag)
    }
    
}
