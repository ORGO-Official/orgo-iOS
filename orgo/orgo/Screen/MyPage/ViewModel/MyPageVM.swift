//
//  MyPageVM.swift
//  orgo
//
//  Created by 김태현 on 2023/08/16.
//

import RxSwift
import RxCocoa
import RxDataSources

final class MyPageVM: BaseViewModel {
    
    // MARK: - Variables and Properties
    
    var input: Input = Input()
    var output: Output = Output()
    
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    
    var bag = DisposeBag()
    
    struct Input {}
    
    struct Output {
        let accessToken = BehaviorRelay(value: KeychainManager.shared.read(for: .accessToken))
        var isAuthenticated: Observable<Bool> {
            accessToken.map { $0 != nil }
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

extension MyPageVM {
    func bindInput() {}
}

// MARK: - Output

extension MyPageVM {
    func bindOutput() {}
}

// MARK: - Networking

extension MyPageVM {
    
    /// 서버에 로그아웃 요청
    func requestLogout() {
        let path = "/api/auth/logout"
        let resource = URLResource<EmptyResponseModel>(path: path)
        
        apiSession.requestPost(urlResource: resource, parameter: nil)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success:
                    KeychainManager.shared.removeAllKeys()
                    owner.output.accessToken.accept(KeychainManager.shared.read(for: .accessToken))
                case .failure(let error):
                    owner.apiError.onNext(error)
                }
            })
            .disposed(by: bag)
    }
    
    /// 서버에 회원탈퇴 요청
    func requestWithdrawal() {
        
    }
    
}

