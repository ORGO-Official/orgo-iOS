//
//  SearchVC.swift
//  orgo
//
//  Created by 김태현 on 2023/09/03.
//

import Foundation

import RxSwift
import RxCocoa
import RxDataSources

import Then
import SnapKit

protocol SearchResultDelegate {
    func selectMountain(_ data: MountainListResponseModel)
}

class SearchVC: BaseViewController {
    
    // MARK: - UI components
    
    let searchField: SearchField = SearchField()
    
    private let searchResultTV: UITableView = UITableView()
        .then {
            $0.rowHeight = 64.0
            $0.backgroundColor = .white
            $0.showsVerticalScrollIndicator = false
            $0.register(SearchResultTVC.self, forCellReuseIdentifier: SearchResultTVC.className)
        }
    
    private let emptySearchResultView: EmptySearchResultView = EmptySearchResultView()
        .then {
            $0.isHidden = true
        }
    
    
    // MARK: - Variables and Properties
    
    private let viewModel: SearchVM = SearchVM()
    var delegate: SearchResultDelegate?
    
    
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
        bindSearchResultTV()
        bindSearchResultSelected()
    }
    
    // MARK: - Functions
    
}


// MARK: - Configure

extension SearchVC {
    
    private func configureInnerView() {
        view.addSubviews([searchField,
                          searchResultTV,
                          emptySearchResultView])
    }
    
}


// MARK: - Layout

extension SearchVC {
    
    private func configureLayout() {
        searchField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60.0)
            $0.leading.trailing.equalToSuperview().inset(8.0)
            $0.height.equalTo(44.0)
        }
        
        searchResultTV.snp.makeConstraints {
            $0.top.equalTo(searchField.snp.bottom).offset(4.0)
            $0.leading.trailing.equalToSuperview().inset(12.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptySearchResultView.snp.makeConstraints {
            $0.center.equalTo(searchResultTV.snp.center)
            $0.leading.trailing.equalToSuperview().inset(80.0)
        }
    }
    
}


// MARK: - Input

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
    
    private func bindSearchResultSelected() {
        searchResultTV.rx.modelSelected(MountainListResponseModel.self)
            .withUnretained(self)
            .bind(onNext: { owner, mountain in
                owner.delegate?.selectMountain(mountain)
                owner.navigationController?.popViewController(animated: true)
            })
            .disposed(by: bag)
    }
}


// MARK: - Output

extension SearchVC {
    
    private func bindSearchResultTV() {
        let dataSource = RxTableViewSectionedReloadDataSource<SearchResultDataSource> { _,
            tableView,
            indexPath,
            searchResult in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTVC.className,
                                                           for: indexPath) as? SearchResultTVC else {
                fatalError("Cannot dequeue Cell")
            }
            
            cell.configureSearchResult(data: searchResult)
            
            return cell
        }
        
        viewModel.output.searchResultDataSource
            .bind(to: searchResultTV.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        viewModel.output.searchResult
            .withUnretained(self)
            .subscribe { owner, items in
                owner.emptySearchResultView.isHidden = !items.isEmpty
            }
            .disposed(by: bag)
    }
    
}
