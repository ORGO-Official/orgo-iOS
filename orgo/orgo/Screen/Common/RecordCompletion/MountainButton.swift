//
//  MountainButton.swift
//  orgo
//
//  Created by 김태현 on 2023/09/27.
//

import UIKit

import Then
import SnapKit

class MountainButton: UIButton {
    
    // MARK: - UI Componenets
    
    private let iconImageView: UIImageView = UIImageView()
        .then {
            $0.image = ImageAssets.locationWhite
            $0.contentMode = .scaleAspectFit
        }
    
    let mountainNameLabel: UILabel = UILabel()
        .then {
            $0.font = UIFont.pretendard(size: 32.0, weight: .bold)
            $0.textColor = .white
            $0.textAlignment = .center
        }
    
    
    // MARK: - Properties
    
    override var isSelected: Bool {
        didSet {
            mountainNameLabel.text = isSelected ? mountain?.englishName : mountain?.rawValue
            sizeToFit()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            adjustSizeForHighlighted()
        }
    }
    
    private var mountain: Mountain?
    
    
    // MARK: - Initialize
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    private func configureButton() {
        backgroundColor = .black.withAlphaComponent(0.3)
        layer.cornerRadius = 13.0
        
        addSubviews([iconImageView, mountainNameLabel])
        
        iconImageView.snp.makeConstraints {
            $0.width.equalTo(18.0)
            $0.height.equalTo(24.0)
            $0.leading.equalToSuperview().offset(19.0)
            $0.centerY.equalToSuperview()
        }
        
        mountainNameLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(19.0)
            $0.top.bottom.equalToSuperview().inset(8.0)
            $0.trailing.equalToSuperview().offset(-31.0)
        }
    }
    
    private func adjustSizeForHighlighted() {
        if isHighlighted {
            iconImageView.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(21.0)
            }
            
            mountainNameLabel.snp.updateConstraints {
                $0.leading.equalTo(iconImageView.snp.trailing).offset(21.0)
                $0.top.bottom.equalToSuperview().inset(11.0)
                $0.trailing.equalToSuperview().offset(-33.0)
            }
        } else {
            iconImageView.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(19.0)
            }
            
            mountainNameLabel.snp.updateConstraints {
                $0.leading.equalTo(iconImageView.snp.trailing).offset(19.0)
                $0.top.bottom.equalToSuperview().inset(8.0)
                $0.trailing.equalToSuperview().offset(-31.0)
            }
        }
    }
    
    func setButton(name: String) {
        mountain = Mountain(rawValue: name)
        mountainNameLabel.text = name
        sizeToFit()
    }
    
}
