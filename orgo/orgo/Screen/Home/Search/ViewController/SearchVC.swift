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
    
    private let viewModel: SearchVM = SearchVM()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchField.becomeFirstResponder()
    }
    
    override func configureView() {
        super.configureView()
        
        configureInnerView()
    }
    
    override func layoutView() {
        super.layoutView()
        
        configureLayout()
    }
    
    override func bindInput() {
        super.bindInput()
        
        bindBackBtn()
        bindSearchField()
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


// MARK: - Bind

extension SearchVC {
    
    private func bindBackBtn() {
        searchField.backBtn.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: bag)
    }
    
    private func bindSearchField() {
        searchField.rx.controlEvent(.editingChanged)
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.viewModel.requestSearch(by: owner.searchField.text)
            }
            .disposed(by: bag)
    }
    
}
