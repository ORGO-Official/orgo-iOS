//
//  BaseViewController.swift
//  orgo
//
//  Created by 김태현 on 2023/07/16.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture

import Then
import SnapKit

class BaseViewController: UIViewController {
    
    // MARK: - UI components
    
    // MARK: - Variables and Properties
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    let keyboardWillShow = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
    let keyboardWillHide = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
    
    var bag = DisposeBag()
  
    var alias: String {
      BaseViewController.className
    }
  
    deinit {
      bag = DisposeBag()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layoutView()
        bindRx()
        hideKeyboard()
    }
    
    // MARK: - Functions
    
    
    // MARK: - Configure
    
    func configureView() {
        view.backgroundColor = UIColor.white
    }
    
    // MARK: - Layout
    
    func layoutView() {}
    
    // MARK: - Bind
    
    func bindRx() {
        bindDependency()
        bindInput()
        bindOutput()
    }
    
    func bindDependency() {}
    
    func bindInput() {}
    
    func bindOutput() {}
    
}

