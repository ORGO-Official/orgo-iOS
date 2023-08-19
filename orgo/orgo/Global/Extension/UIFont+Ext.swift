//
//  UIFont+Ext.swift
//  orgo
//
//  Created by 김태현 on 2023/08/19.
//

import Foundation

extension UIFont {
    
    static func pretendard(size fontSize: CGFloat, weight fontWeight: PretendardWeight) -> UIFont {
        return UIFont(name: fontWeight.fontName(), size: fontSize)!
    }
    
}
