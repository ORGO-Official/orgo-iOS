//
//  SearchResultTVC.swift
//  orgo
//
//  Created by 김태현 on 2023/09/04.
//

import UIKit

import SnapKit
import Then

import RxSwift
import RxGesture
import RxCocoa

class SearchResultTVC: BaseTableViewCell {
    
    // MARK: - UI components
    
    private let locationImageView: UIImageView = UIImageView()
        .then {
            $0.image = ImageAssets.location
        }
    
    private let mountainNameLabel: UILabel = UILabel()
        .then {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 18.0, weight: .medium)
        }
    
    private let addressLabel: UILabel = UILabel()
        .then {
            $0.textColor = .gray
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
        }
    
    private let borderView: UIView = UIView()
        .then {
            $0.backgroundColor = .lightGray
        }
        
    
    // MARK: - Variables and Properties
    
    // MARK: - Life Cycle
    
    override func configureView() {
        super.configureView()
        
        configureContentView()
    }
    
    override func layoutView() {
        super.layoutView()
        
        configureLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mountainNameLabel.text = .empty
        addressLabel.text = .empty
    }

    // MARK: - Function
    
    func configureSearchResult(data: MountainListResponseModel) {
        mountainNameLabel.text = data.name
        addressLabel.text = data.address
    }
    
}


// MARK: - Confgure

extension SearchResultTVC {
    
    private func configureContentView() {
        contentView.addSubviews([locationImageView,
                                 mountainNameLabel,
                                 addressLabel,
                                 borderView])
        
        selectionStyle = .none
        backgroundColor = .white
    }
    
}


// MARK: - Layout

extension SearchResultTVC {
    
    private func configureLayout() {
        locationImageView.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(16.0)
            $0.width.equalTo(12.0)
            $0.height.equalTo(16.0)
        }
        
        mountainNameLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(12.0)
            $0.leading.equalTo(locationImageView.snp.trailing).offset(13.0)
            $0.height.equalTo(18.0)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(mountainNameLabel.snp.bottom).offset(6.0)
            $0.leading.equalTo(locationImageView.snp.trailing).offset(13.0)
            $0.height.equalTo(14.0)
        }
        
        borderView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(contentView)
            $0.height.equalTo(1.0)
        }
    }
    
}
