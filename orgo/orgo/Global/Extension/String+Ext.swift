//
//  String+Ext.swift
//  orgo
//
//  Created by 김태현 on 2023/07/16.
//

import Foundation

extension String {
    
    static var empty: Self {
        ""
    }
    
    var localized: Self {
        NSLocalizedString(self, comment: .empty)
    }
    
}
