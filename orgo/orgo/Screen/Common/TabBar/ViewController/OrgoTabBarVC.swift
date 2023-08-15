//
//  OrgoTabBarVC.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import Foundation

import RxSwift
import RxCocoa

import Then
import SnapKit

class OrgoTabBarVC: BaseViewController {
    
    // MARK: - UI components
    
    private let tabBarView: TabBarView = TabBarView()
    
    
    // MARK: - Variables and Properties
    
    private let tabBarItems: [TabBarItem] = TabBarItem.allCases
    private var vcList: [BaseNavigationController] = []
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStart(targetItemType: .home)
    }
    
    override func configureView() {
        super.configureView()
        
        configureInnerVC()
        configureTabBarView()
    }
    
    override func layoutView() {
        super.layoutView()
        
        configureLayout()
    }
    
    
    // MARK: - Functions
    
    private func setStart(targetItemType: TabBarItem) {
        activeTabBarItem(targetItemType: targetItemType)
    }
    
    func activeTabBarItem(targetItemType: TabBarItem) {
        tabBarView.stackView.arrangedSubviews.forEach {
            guard let itemBtn = $0 as? TabBarItemButton else { return }
            let itemBtnType = itemBtn.itemType
            
            let isSelected = itemBtnType == targetItemType
            itemBtn.setButtonStatus(isSelected: isSelected)
        }
        
        for index in 0..<vcList.count {
            let targetVC = vcList[index]
            if index == targetItemType.index {
                embed(with: targetVC)
                targetVC.view.snp.makeConstraints {
                    $0.top.horizontalEdges.equalTo(view)
                    $0.bottom.equalTo(tabBarView.snp.top)
                }
            } else {
                remove(of: targetVC)
            }
        }
    }
    
    func getTabBarInnerInstance(targetItemType: TabBarItem) -> BaseNavigationController? {
        for index in 0..<vcList.count {
            if index == targetItemType.index {
                return vcList[index]
            }
        }
        
        return nil
    }
    
}


// MARK: - Configure

extension OrgoTabBarVC {
    
    private func configureInnerVC() {
        tabBarItems.forEach {
            vcList.append(BaseNavigationController(rootViewController: $0.createTabBarInnerVC()))
        }
    }
    
    private func configureTabBarView() {
        tabBarItems.forEach {
            let itemBtn = TabBarItemButton(for: $0)
            tabBarView.stackView.addArrangedSubview(itemBtn)
            
            itemBtn.rx.tap
                .asDriver()
                .drive(onNext: { [weak self] _ in
                    guard let self = self else { return }

                    self.activeTabBarItem(targetItemType: itemBtn.itemType)
                })
                .disposed(by: bag)
        }
    }
    
}


// MARK: - Layout

extension OrgoTabBarVC {
    
    private func configureLayout() {
        view.addSubview(tabBarView)
        
        tabBarView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
