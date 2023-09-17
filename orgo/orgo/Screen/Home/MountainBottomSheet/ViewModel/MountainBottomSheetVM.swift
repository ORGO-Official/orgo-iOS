//
//  MountainBottomSheetVM.swift
//  orgo
//
//  Created by 김태현 on 2023/09/17.
//

import RxCocoa
import RxSwift

final class MountainBottomSheetVM: BaseViewModel {
    
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

extension MountainBottomSheetVM: Input {
    func bindInput() {}
}

// MARK: - Output

extension MountainBottomSheetVM: Output {
    func bindOutput() {}
}

// MARK: - Networking

extension MountainBottomSheetVM {
    
}
