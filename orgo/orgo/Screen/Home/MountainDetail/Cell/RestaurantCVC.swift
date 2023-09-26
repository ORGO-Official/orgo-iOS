//
//  RestaurantCVC.swift
//  orgo
//
//  Created by 김태현 on 2023/08/29.
//

import UIKit

import Then
import SnapKit

class RestaurantCVC: BaseCollectionViewCell {

    // MARK: - UI components
    
    let thumbnailImageView = UIImageView()
        .then {
            $0.contentMode = .scaleToFill
            $0.layer.cornerRadius = 5.0
            $0.layer.masksToBounds = true
        }
    
    let restaurantTitle = UILabel()
        .then {
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(size: 14.0, weight: .medium)
            $0.numberOfLines = 2
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

    
    // MARK: - Function
    
    func configureData(from restaurant: RestaurantListResponseModel) {
        thumbnailImageView.setImage(with: restaurant.imageUrl)
        restaurantTitle.text = restaurant.name
    }
    
}


// MARK: - Configure

extension RestaurantCVC {
    
    private func configureContentView() {
        addSubviews([thumbnailImageView,
                     restaurantTitle])
    }
    
}


// MARK: - Layout

extension RestaurantCVC {
    
    private func configureLayout() {
        thumbnailImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(thumbnailImageView.snp.width)
        }
        
        restaurantTitle.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(4.0)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
}
