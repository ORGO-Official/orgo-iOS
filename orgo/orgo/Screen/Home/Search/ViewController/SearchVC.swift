//
//  SearchVC.swift
//  orgo
//
//  Created by 김태현 on 2023/09/03.
//

import Foundation

import RxSwift
import RxCocoa

import Then
import SnapKit

class SearchVC: BaseViewController {
    
    // MARK: - UI components
    
    let searchField: SearchField = SearchField()
    
    
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
    
    // MARK: - Functions
    
}


// MARK: - Configure

extension SearchVC {
    
    private func configureInnerView() {
        view.addSubviews([searchField])
    }
    
}


// MARK: - Layout

extension SearchVC {
    
    private func configureLayout() {
        searchField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(60.0)
            $0.leading.trailing.equalToSuperview().inset(8.0)
            $0.height.equalTo(44.0)
        }
    }
    
}
