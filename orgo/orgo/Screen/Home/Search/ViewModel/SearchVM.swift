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
    
}
