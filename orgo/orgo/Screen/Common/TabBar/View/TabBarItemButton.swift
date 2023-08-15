//
//  TabBarItemButton.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import UIKit

import Then
import SnapKit

class TabBarItemButton: UIButton {
    
    // MARK: - UI components
    
    private let stackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .fill
            $0.spacing = 2.0
            
            $0.isUserInteractionEnabled = false
        }
    
    let iconImageView = UIImageView()
        .then {
            $0.contentMode = .scaleAspectFit
            $0.isUserInteractionEnabled = false
        }

    
    // MARK: - Variables and Properties
    
    let itemType: TabBarItem
    
    // MARK: - Life Cycle
    
    init(frame: CGRect = .zero, for itemType: TabBarItem) {
        self.itemType = itemType
        super.init(frame: frame)
        
        configureButton()
        configreLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func setButtonStatus(isSelected: Bool) {
        let toSetColor = isSelected ? UIColor.black : UIColor.gray
        iconImageView.image = itemType.iconImage?.withTintColor(toSetColor)
        tintColor = toSetColor
    }
    
}

// MARK: - Configure

extension TabBarItemButton {
    
    private func configureButton() {
        addSubviews([stackView])
        iconImageView.image = itemType.iconImage
    }
    
}

// MARK: - Layout

extension TabBarItemButton {
    
    private func configreLayout() {
        [iconImageView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(self).offset(6.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self).inset(6.0)
        }
    }
    
}
