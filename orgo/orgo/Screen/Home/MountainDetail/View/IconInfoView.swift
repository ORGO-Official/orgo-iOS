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
            
            iconCell.configureIcon(image: ImageAssets.courseIcon, title: "\(featureTag.totalCourse)개의 코스", activate: true)
            iconStackView.addArrangedSubview(iconCell)
        }
        
        let goodNightIconCell = makeIconCell(type: .gootNightView, activate: featureTag.goodNightView)
        let parkingIconCell = makeIconCell(type: .parkingLot, activate: featureTag.parkingLot)
        let restRoomIconCell = makeIconCell(type: .restRoom, activate: featureTag.restRoom)
        
        [goodNightIconCell, parkingIconCell, restRoomIconCell]
            .sorted(by: { $0.isActivate && !$1.isActivate })
            .forEach {
                iconStackView.addArrangedSubview($0)
            }
    }
    
    private func makeIconCell(type: FeatureTagType, activate: Bool) -> IconInfoCell {
        let iconCell = IconInfoCell()
        
        iconCell.configureIcon(image: type.image, title: type.title, activate: activate)
        return iconCell
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
