//
//  NavigationBar.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import Foundation

import Then
import SnapKit

class NavigationBar: UIView {
    
    // MARK: - UI components
    
    let titleLabel: UILabel = UILabel()
        .then {
            $0.font = UIFont.pretendard(size: 20.0, weight: .medium)
            $0.textColor = .black
        }
    
    let leftBtn: UIButton = UIButton(type: .system)
        .then {
            $0.tintColor = .black
            $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        }
    
    let rightBtn: UIButton = UIButton(type: .system)
        .then {
            $0.tintColor = .black
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        }
    
    var style: NavigationBarStyle {
        didSet {
            updateVisability()
        }
    }
    
    private let height: CGFloat
    
    private let borderStackView = UIStackView()
        .then {
            $0.spacing = .zero
            $0.distribution = .fill
            $0.alignment = .fill
            $0.axis = .vertical
        }
    
    private let contentStackView = UIStackView()
        .then {
            $0.spacing = .zero
            $0.distribution = .fill
            $0.alignment = .fill
            $0.axis = .horizontal
        }
    
    private let borderView = UIView()
        .then {
            $0.backgroundColor = .gray
        }
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect = .zero,
         style: NavigationBarStyle,
         title: String?,
         height: CGFloat = 48.0) {
        self.style = style
        self.height = height
        
        super.init(frame: frame)
        
        self.titleLabel.text = title
        
        configureView()
        configureLayout()
    }
    

    // MARK: - Functions
    
    func updateVisability() {
        [leftBtn, rightBtn].forEach { $0.isHidden = false }
        
        var inset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
        
        switch style {
        case .default:
            leftBtn.isHidden = true
            rightBtn.isHidden = true
            inset.left = 20.0
        case .left:
            rightBtn.isHidden = true
        case .right:
            leftBtn.isHidden = true
            inset.left = 20.0
        }
        
        contentStackView.layoutMargins = inset
        contentStackView.isLayoutMarginsRelativeArrangement = true
    }
    
}


// MARK: - Configure

extension NavigationBar {
    
    private func configureView() {
        backgroundColor = .white
        
        addSubview(borderStackView)
    }
    
}


// MARK: - Layout

extension NavigationBar {
    
    private func configureLayout() {
        borderStackView.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().priority(.low)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        borderStackView.addArrangedSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.height.equalTo(height)
        }
        
        [leftBtn, titleLabel, rightBtn].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        leftBtn.snp.makeConstraints {
            $0.width.equalTo(leftBtn.snp.height)
        }
        
        borderStackView.addArrangedSubview(borderView)
        borderView.snp.makeConstraints {
            $0.height.equalTo(1.0)
        }
        
        updateVisability()
    }
    
}
