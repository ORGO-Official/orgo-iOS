//
//  BaseTableViewCell.swift
//  orgo
//
//  Created by 김태현 on 2023/07/16.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - UI components
    
    // MARK: - Variables and Properties
    
    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
