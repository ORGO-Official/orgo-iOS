//
//  FloatingButton.swift
//  orgo
//
//  Created by 김태현 on 2023/09/17.
//

import UIKit

import Then
import SnapKit

class FloatingButton: UIButton {
    
    // MARK: - UI components
    
    private let innerView = UIView()
        .then {
            $0.isUserInteractionEnabled = false
            $0.backgroundColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 25.0
            
            $0.layer.shadowColor = CGColor(red: 23.0 / 255.0, green: 23.0 / 255.0, blue: 23.0 / 255.0, alpha: 1)
            $0.layer.shadowOpacity = 0.2
            $0.layer.shadowRadius = 6.0
            $0.layer.shadowOffset = CGSize(width: 0, height: 0)
            
            $0.layer.masksToBounds = false
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    
    private let iconImageView: UIImageView = UIImageView()
        .then {
            $0.contentMode = .scaleAspectFit
        }
    
    // MARK: - Life Cycle
    
    init(frame: CGRect = .zero, image: UIImage?) {
        super.init(frame: frame)
        
        configureButton(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            innerView.backgroundColor = isHighlighted ? ColorAssets.lightGray : .white
        }
    }
    
}


// MARK: - Configure

extension FloatingButton {
    
    private func configureButton(image: UIImage?) {
        addSubview(innerView)
        innerView.addSubview(iconImageView)
        iconImageView.image = image
        
        innerView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.edges.equalToSuperview().inset(15.0)
        }
    }
    
}
