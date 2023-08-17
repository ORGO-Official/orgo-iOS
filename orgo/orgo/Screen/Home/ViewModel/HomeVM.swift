//
//  HomeVM.swift
//  orgo
//
//  Created by 김태현 on 2023/08/18.
//

import RxCocoa
import RxSwift

final class HomeVM: BaseViewModel {
    
    // MARK: - Variables and Properties
    
    var input = Input()
    var output = Output()
    
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    
    var bag = DisposeBag()
    
    struct Input {}
    struct Output {
        var loading = BehaviorRelay<Bool>(value: false)
        
        var mountainList = BehaviorRelay<Array<MountainListResponseModel>>(value: [])
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

extension HomeVM: Input {
    func bindInput() {}
}

// MARK: - Output

extension HomeVM: Output {
    func bindOutput() {}
}

// MARK: - Networking

extension HomeVM {
    
    /// 서버에 산 목록 조회 요청
    func requestGetMountainList() {
        let path = "/api/mountains"
        let resource = URLResource<Array<MountainListResponseModel>>(path: path)
        
        apiSession.requestGet(urlResource: resource)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let data):
                    owner.output.mountainList.accept(data)
                case .failure(let error):
                    owner.apiError.onNext(error)
                }
            })
            .disposed(by: bag)
    }
    
}

