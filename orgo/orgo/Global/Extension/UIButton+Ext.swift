//
//  UIButton+Ext.swift
//  orgo
//
//  Created by 김태현 on 2023/08/27.
//

import UIKit

extension UIButton {
    
    /// UIButton의 State에 따라 backgroundColor를 변경
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let minimumSize: CGSize = CGSize(width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(minimumSize)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(origin: .zero, size: minimumSize))
        }
        
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        clipsToBounds = true
        setBackgroundImage(colorImage, for: state)
    }
    
}
