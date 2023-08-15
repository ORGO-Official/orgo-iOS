//
//  BaseNavigationController.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    // MARK: - UI components
    
    
    // MARK: - Variables and Properties
    
    var rootViewController: UIViewController? {
        viewControllers.first
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
        navigationBar.isHidden = true
    }
    
    // MARK: - Functions
}


// MARK: - UIGestureRecognizerDelegate

extension BaseNavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        self.viewControllers.count > 1
    }
    
}
