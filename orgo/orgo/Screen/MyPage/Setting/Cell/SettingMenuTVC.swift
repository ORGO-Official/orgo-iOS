//
//  SettingMenuTVC.swift
//  orgo
//
//  Created by 김태현 on 2023/09/12.
//

import UIKit

import SnapKit
import Then

class SettingMenuTVC: BaseTableViewCell {
    
    // MARK: - UI components
    
    let titleLabel: UILabel = UILabel()
        .then {
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(size: 14.0, weight: .medium)
        }
    
    let borderView: UIView = UIView()
        .then {
            $0.backgroundColor = ColorAssets.lightGray
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    // MARK: - Function
    
    func configureMenu(menuType: SettingMenu) {
        titleLabel.text = menuType.description
    }
}


// MARK: - Configure

extension SettingMenuTVC {
    
    private func configureInnerView() {
        contentView.addSubviews([titleLabel,
                                 borderView])
        
        backgroundColor = .white
    }
    
}


// MARK: - Layout

extension SettingMenuTVC {
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.center.equalTo(contentView)
            $0.height.equalTo(14.0)
        }
        
        borderView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(contentView)
            $0.height.equalTo(1.0)
        }
    }
    
}
