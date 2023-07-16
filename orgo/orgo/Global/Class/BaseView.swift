//
//  BaseView.swift
//  orgo
//
//  Created by 김태현 on 2023/07/16.
//

import UIKit

import SnapKit
import Then

class BaseView: UIView {
    
    // MARK: - UI components
    
    // MARK: - Variables and Properties
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Functions
    
    func configureView() {}
    
    func layoutView() {}
}
