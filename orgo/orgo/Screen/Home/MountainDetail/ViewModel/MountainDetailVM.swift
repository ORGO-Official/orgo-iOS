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
        
        var restaurantList = BehaviorRelay<Array<MountainListResponseModel>>(value: [])
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
    
    func requestGetRestaurantList() {
        
    }
    
}
