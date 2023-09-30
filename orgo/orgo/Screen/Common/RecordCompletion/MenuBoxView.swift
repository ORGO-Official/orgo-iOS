//
//  MenuBoxView.swift
//  orgo
//
//  Created by 김태현 on 2023/09/30.
//

import Foundation

import SnapKit
import Then

import RxSwift
import RxCocoa
import RxGesture

class MenuBoxView: BaseView {
    
    // MARK: - UI components
    
    private let upperTapArea: UIView = UIView()
        .then {
            $0.backgroundColor = .clear
        }
    
    private let upperThumbnailImageView: UIImageView = UIImageView()
    
    private let upperTitleLabel: UILabel = UILabel()
        .then {
            $0.font = UIFont.pretendard(size: 14.0, weight: .medium)
            $0.textColor = .white
            $0.textAlignment = .center
        }
    
    private let borderView: UIView = UIView()
        .then {
            $0.backgroundColor = .white
        }
    
    private let lowerTapArea: UIView = UIView()
        .then {
            $0.backgroundColor = .clear
        }
    
    private let lowerThumbnailImageView: UIImageView = UIImageView()
    
    private let lowerTitleLabel: UILabel = UILabel()
        .then {
            $0.font = UIFont.pretendard(size: 14.0, weight: .medium)
            $0.textColor = .white
            $0.textAlignment = .center
        }
    
    
    // MARK: - Variables and Properties
    
    private var bag = DisposeBag()
    
    
    // MARK: - Life Cycle
    
    init(frame: CGRect = .zero, type: MenuType) {
        super.init(frame: frame)
        
        configureMenu(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureView() {
        super.configureView()
        
        configureInnerView()
        bindTap()
    }
    
    override func layoutView() {
        super.layoutView()
        
        configureLayout()
    }
    
    // MARK: - Functions
    
    private func configureMenu(type: MenuType) {
        upperThumbnailImageView.image = type.upperThumbnailImage
        upperTitleLabel.text = type.upperTitle
        lowerThumbnailImageView.image = type.lowerThumbnailImage
        lowerTitleLabel.text = type.lowerTitle
    }
    
}


// MARK: - Configure

extension MenuBoxView {
    
    private func configureInnerView() {
        backgroundColor = .black.withAlphaComponent(0.7)
        
        addSubviews([upperTapArea,
                     borderView,
                     lowerTapArea])
        
        upperTapArea.addSubviews([upperThumbnailImageView,
                                  upperTitleLabel])
        
        lowerTapArea.addSubviews([lowerThumbnailImageView,
                                  lowerTitleLabel])
    }
    
    private func bindTap() {
        upperTapArea.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.isHidden = true
            })
            .disposed(by: bag)
        
        lowerTapArea.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.isHidden = true
            })
            .disposed(by: bag)
    }
    
}


// MARK: - Layout

extension MenuBoxView {
    
    private func configureLayout() {
        upperTapArea.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(borderView.snp.top)
        }
        
        upperThumbnailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(34.0)
            $0.height.width.equalTo(28.0)
        }
        
        upperTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(upperThumbnailImageView.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().offset(-8.0)
        }
        
        borderView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(11.0)
            $0.height.equalTo(1.0)
        }
        
        lowerTapArea.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        lowerThumbnailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(34.0)
            $0.height.width.equalTo(28.0)
        }
        
        lowerTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(lowerThumbnailImageView.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().offset(-8.0)
        }
    }
    
}
