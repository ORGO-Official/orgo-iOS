//
//  EmptySearchResultView.swift
//  orgo
//
//  Created by 김태현 on 2023/09/04.
//

import UIKit

import Then
import SnapKit

class EmptySearchResultView: BaseView {
    
    // MARK: - UI components
    
    private let imageView: UIImageView = UIImageView()
        .then {
            $0.image = ImageAssets.roundExclamation
            $0.contentMode = .scaleToFill
        }
    
    private let stackView: UIStackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 12.0
        }
    
    private let upperLabel: UILabel = UILabel()
        .then {
            $0.text = "검색 결과가 없습니다."
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(size: 18.0, weight: .medium)
        }
    
    private let lowerLabel: UILabel = UILabel()
        .then {
            $0.text = "단어의 철자가 정확한지 확인해 주세요.\n다른 검색어로 검색해 보세요."
            $0.numberOfLines = 0
            $0.textColor = ColorAssets.gray
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(size: 13.0, weight: .medium)
        }
    
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    override func configureView() {
        super.configureView()
        
        configureInnerView()
    }
    
    override func layoutView() {
        super.layoutView()
        
        configureLayout()
    }
    
    // MARK: - Functions
    
}


// MARK: - Configure

extension EmptySearchResultView {
    
    private func configureInnerView() {
        addSubviews([imageView,
                     stackView])
        
        [upperLabel, lowerLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        backgroundColor = .white
    }
    
}


// MARK: - Layout

extension EmptySearchResultView {
    
    private func configureLayout() {
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.width.equalTo(62.0)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20.0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
