//
//  BaseCollectionViewCell.swift
//  orgo
//
//  Created by 김태현 on 2023/07/16.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
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
    
    // MARK: - Function
    
    func configureView() {}
    
    func layoutView() {}
}
