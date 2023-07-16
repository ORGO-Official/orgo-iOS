//
//  UIView+Ext.swift
//  orgo
//
//  Created by 김태현 on 2023/07/16.
//

import UIKit

extension UIView {
 
    /// SubView 여러 개 한번에 추가
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    /// 클래스 이름 String으로 반환
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
    
    /// UIView를 담당하는 ViewController 리턴
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }

    /// UIView에 라운드 코너값 설정
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /// UIView에 Shadow 추가
    func addShadow(opacity: Float? = 0.4) {
        layer.shadowColor = CGColor(red: 23.0 / 255.0, green: 23.0 / 255.0, blue: 23.0 / 255.0, alpha: 1)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 8.0
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
    }
    
}
