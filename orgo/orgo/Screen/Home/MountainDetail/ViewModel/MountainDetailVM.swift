//
//  MountainDetailVM.swift
//  orgo
//
//  Created by 김태현 on 2023/08/28.
//

import RxCocoa
import RxSwift

final class MountainDetailVM: BaseViewModel {
    
    // MARK: - Variables and Properties
    
    var input = Input()
    var output = Output()
    
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    
    var bag = DisposeBag()
    
    struct Input {}
    struct Output {
        var loading = BehaviorRelay<Bool>(value: false)
        
        var restaurantList = BehaviorRelay<Array<RestaurantListResponseModel>>(value: [])
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

extension MountainDetailVM: Input {
    func bindInput() {}
}

// MARK: - Output

extension MountainDetailVM: Output {
    func bindOutput() {}
}

// MARK: - Networking

extension MountainDetailVM {
    
    /// 서버에 근처 식당 목록 조회 요청
    func requestGetRestaurantList(mountainId: Int) {
        let path = "/api/mountains/\(mountainId)/restaurants"
        let resource = URLResource<Array<RestaurantListResponseModel>>(path: path)
        
        apiSession.requestGet(urlResource: resource)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let data):
                    owner.output.restaurantList.accept(data)
                case .failure(let error):
                    owner.apiError.onNext(error)
                }
            })
            .disposed(by: bag)
    }
    
}
