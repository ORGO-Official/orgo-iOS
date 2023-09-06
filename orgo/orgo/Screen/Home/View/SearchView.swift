//
//  SearchView.swift
//  orgo
//
//  Created by 김태현 on 2023/09/03.
//

import UIKit

import SnapKit
import Then

class SearchView: BaseView {
    
    // MARK: - UI components
    
    let searchImageView: UIImageView = UIImageView()
        .then {
            $0.tintColor = .black
            $0.image = UIImage(systemName: "magnifyingglass")
        }
    
    let searchLabel: UILabel = UILabel()
        .then {
            $0.textColor = .lightGray
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 20.0, weight: .medium)
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

extension SearchView {
    
    private func configureInnerView() {
        addSubviews([searchImageView,
                     searchLabel])
        
        backgroundColor = .white
        
        layer.cornerRadius = 16.0
        
        layer.shadowColor = CGColor(red: 23.0 / 255.0, green: 23.0 / 255.0, blue: 23.0 / 255.0, alpha: 1)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 7.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
}


// MARK: - Layout

extension SearchView {
    
    private func configureLayout() {
        searchImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.0)
            $0.width.height.equalTo(20.0)
        }
        
        searchLabel.snp.makeConstraints {
            $0.leading.equalTo(searchImageView.snp.trailing).offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.height.equalTo(20.0)
            $0.centerY.equalToSuperview()
        }
    }
    
}
