//
//  SettingVC.swift
//  orgo
//
//  Created by 김태현 on 2023/09/07.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

import Then
import SnapKit

class SettingVC: BaseNavigationViewController {
    
    // MARK: - UI components
    
    let settingMenuTV: UITableView = UITableView()
        .then {
            $0.rowHeight = 52.0
            $0.backgroundColor = .white
            $0.showsVerticalScrollIndicator = false
            $0.separatorStyle = .none
        }
    
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        super.configureView()
        
        configureInnerView()
    }
    
    override func layoutView() {
        super.layoutView()
        
        configureLayout()
    }
    
    override func bindOutput() {
        super.bindOutput()
        
        bindSettingMenuTV()
    }
    
    // MARK: - Functions
    
}


// MARK: - Configure

extension SettingVC {
    
    private func configureInnerView() {
        title = "설정"
        navigationBar.style = .left
        
        view.addSubviews([settingMenuTV])
    }
    
}


// MARK: - Layout

extension SettingVC {
    
    private func configureLayout() {
        settingMenuTV.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}


// MARK: - Output

extension SettingVC {
    
    private func bindSettingMenuTV() {
        let dataSource = RxTableViewSectionedReloadDataSource<SettingMenuDataSource> { _,
            tableView,
            indexPath,
            record in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingMenuTVC.className,
                                                           for: indexPath) as? SettingMenuTVC else {
                fatalError("Cannot dequeue Cell")
            }
            
            
            return cell
        }
    }
    
}
