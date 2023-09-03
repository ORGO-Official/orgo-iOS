//
//  SearchVM.swift
//  orgo
//
//  Created by 김태현 on 2023/09/03.
//

import RxCocoa
import RxSwift

final class SearchVM: BaseViewModel {
    
    // MARK: - Variables and Properties
    
    var input = Input()
    var output = Output()
    
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    
    var bag = DisposeBag()
    
    struct Input {}
    struct Output {
        var searchResult = PublishRelay<Array<MountainListResponseModel>>()
        
        var searchResultDataSource: Observable<Array<SearchResultDataSource>> {
            searchResult.map { [SearchResultDataSource(items: $0)] }
        }
    }
    
    // MARK: - Life Cycle
    
    init() {
        bindInput()
        bindOutput()
    }
    
    deinit {
        bag = DisposeBag()
    }
    
}


// MARK: - Input

extension SearchVM: Input {
    func bindInput() {}
}


// MARK: - Output

extension SearchVM: Output {
    func bindOutput() {}
}


// MARK: - Networking

extension SearchVM {
    
    func requestSearch(by searchString: String?) {
        guard let searchString = searchString else { return }
        if searchString.isEmpty { return }
        
        let path = "/api/mountains?keyword=\(searchString)"
        let resource = URLResource<Array<MountainListResponseModel>>(path: path)
        
        apiSession.requestGet(urlResource: resource)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let data):
                    owner.output.searchResult.accept(data)
                case .failure(let error):
                    owner.apiError.onNext(error)
                }
            })
            .disposed(by: bag)
    }
    
}
