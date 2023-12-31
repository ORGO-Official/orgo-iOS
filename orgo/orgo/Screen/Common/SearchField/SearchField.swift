//
//  SearchField.swift
//  orgo
//
//  Created by 김태현 on 2023/09/03.
//

import UIKit

import Then
import SnapKit

class SearchField: UITextField {
    
    let backBtn: UIButton = UIButton(type: .custom)
        .then {
            $0.tintColor = .black
            $0.contentMode = .scaleAspectFit
            $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        }
    
    let backBtnView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSearchField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Configure

extension SearchField {
    
    private func configureSearchField() {
        layer.borderColor = ColorAssets.lightGray.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 16.0
        layer.masksToBounds = true
        
        attributedPlaceholder = NSAttributedString(string: "산 이름 검색",
                                                   attributes: [NSAttributedString.Key.foregroundColor: ColorAssets.lightGray,
                                                                NSAttributedString.Key.font: UIFont.pretendard(size: 18.0, weight: .medium)])
        
        backBtn.frame = CGRect(x: 10, y: 0, width: 12, height: 24)
        backBtnView.frame = CGRect(x: 0, y: 0, width: 36, height: 24)
        backBtnView.addSubview(backBtn)
        
        backgroundColor = .white
        
        font = UIFont.pretendard(size: 18.0, weight: .medium)
        
        textColor = .black
        
        leftView = backBtnView
        leftViewMode = .always
    }
            
}

