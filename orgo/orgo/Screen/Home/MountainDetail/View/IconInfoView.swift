//
//  IconInfoView.swift
//  orgo
//
//  Created by 김태현 on 2023/09/15.
//

import UIKit

import SnapKit
import Then

class IconInfoView: BaseView {
    
    // MARK: - UI components
    
    let iconStackView: UIStackView = UIStackView()
        .then {
            $0.spacing = 6.0
            $0.distribution = .fillEqually
            $0.alignment = .center
            $0.axis = .horizontal
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
    
    func configureIcon(by data: MountainListResponseModel) {
        let featureTag = data.featureTag
        
        if featureTag.totalCourse > 0 {
            let iconCell = IconInfoCell()
            
            iconCell.configureIcon(image: ImageAssets.nightViewIcon, title: "\(featureTag.totalCourse)개의 코스")
            iconStackView.addArrangedSubview(iconCell)
        }
        
        if featureTag.goodNightView {
            let iconCell = IconInfoCell()
            
            iconCell.configureIcon(image: ImageAssets.nightViewIcon, title: "야경 맛집")
            iconStackView.addArrangedSubview(iconCell)
        }
        
        if featureTag.parkingLot {
            let iconCell = IconInfoCell()
            
            iconCell.configureIcon(image: ImageAssets.parkingIcon, title: "주차장")
            iconStackView.addArrangedSubview(iconCell)
        }
        
        if featureTag.restRoom {
            let iconCell = IconInfoCell()
            
            iconCell.configureIcon(image: ImageAssets.toiletIcon, title: "화장실")
            iconStackView.addArrangedSubview(iconCell)
        }
        
        if featureTag.cableCar {
            let iconCell = IconInfoCell()
            
            iconCell.configureIcon(image: ImageAssets.cableCarIcon, title: "케이블카")
            iconStackView.addArrangedSubview(iconCell)
        }
    }
    
}


// MARK: - Configure

extension IconInfoView {
    
    private func configureInnerView() {
        addSubviews([iconStackView])
    }
    
}


// MARK: - Layout

extension IconInfoView {
    
    private func configureLayout() {
        iconStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
