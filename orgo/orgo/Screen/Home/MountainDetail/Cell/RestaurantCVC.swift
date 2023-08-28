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
    }
    
}


// MARK: - Configure

extension RestaurantCVC {
    
    private func configureContentView() {
        addSubviews([thumbnailImageView])
    }
    
}


// MARK: - Layout

extension RestaurantCVC {
    
    private func configureLayout() {
        thumbnailImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(thumbnailImageView.snp.width)
        }
    }
    
}
