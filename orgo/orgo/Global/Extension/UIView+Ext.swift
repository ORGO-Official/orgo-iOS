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
    func addShadow(x: Double, y: Double, blur: Double, opacity: Float) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = blur
        layer.shadowOffset = CGSize(width: x, height: y)
    }
    
    /// 뷰를 캡쳐해 이미지로 반환
    func capture() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let capturedImage = renderer.image { _ in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        return capturedImage
    }
    
}
