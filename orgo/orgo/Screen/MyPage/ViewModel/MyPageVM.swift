//
//  MyPageVM.swift
//  orgo
//
//  Created by 김태현 on 2023/08/16.
//

import Foundation

import RxSwift
import RxCocoa

import Alamofire

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
        
        var isLogoutSuccess = PublishRelay<Bool>()
        var isWithdrawalSuccess = PublishRelay<Bool>()
        
        var userInfo = BehaviorRelay<UserInfoResponseModel>(value: UserInfoResponseModel(id: 0,
                                                                                         nickname: .empty,
                                                                                         email: .empty,
                                                                                         profileImage: .empty,
                                                                                         loginType: .empty))
        
        var recordList = PublishRelay<RecordListResponseModel>()
        var recordDataSource: Observable<Array<RecordDataSource>> {
            recordList
                .map({ $0.climbingRecordDtoList.reversed() })
                .map({ [RecordDataSource(items: $0)] })
        }
        var totalRecord = BehaviorRelay(value: (0.0, 0))
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

// MARK: - Networking - Logout

extension MyPageVM {
    
    /// 로그아웃 요청
    func requestLogout() {
        let path = "/api/auth/logout"
        let resource = URLResource<EmptyResponseModel>(path: path)
        
        APIToken.refreshSocialToken()
        guard let socialToken = KeychainManager.shared.read(for: .identifier) else { return }
        
        requestLogoutOrWithdrawal(urlResource: resource, socialToken: socialToken)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success:
                    KeychainManager.shared.removeAllKeys()
                    owner.output.accessToken.accept(KeychainManager.shared.read(for: .accessToken))
                    owner.output.isLogoutSuccess.accept(true)
                case .failure(let error):
                    owner.apiError.onNext(error)
            }
        })
        .disposed(by: bag)
    }
    
    /// 서버로 로그아웃 요청
    private func requestLogoutOrWithdrawal<T: Decodable>(urlResource: URLResource<T>, socialToken: String) -> Observable<Result<T, APIError>> {
        Observable<Result<T, APIError>>.create { observer in
            var headers = HTTPHeaders()
            headers.add(.accept("*/*"))
            headers.add(.contentType("application/x-www-form-urlencoded"))
            headers.add(name: "social", value: socialToken)
            
            let task = AF.request(urlResource.resultURL,
                                  method: .post,
                                  encoding: JSONEncoding.default,
                                  headers: headers,
                                  interceptor: AuthInterceptor())
                .validate(statusCode: 200...399)
                .responseDecodable(of: T.self) { response in
                    debugPrint(response)
                    switch response.result {
                    case .success(let data):
                        observer.onNext(.success(data))
                    case .failure(let error):
                        dump(error)
                        guard let error = response.response else { return }
                        observer.onNext(urlResource.judgeError(statusCode: error.statusCode))
                    }
                }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}


// MARK: - Networking - Withdrawal

extension MyPageVM {
    
    /// 서버에 회원탈퇴 요청
    func requestWithdrawal() {
        let path = "/api/auth/withdraw"
        let resource = URLResource<EmptyResponseModel>(path: path)
        
        APIToken.refreshSocialToken()
        guard let socialToken = KeychainManager.shared.read(for: .identifier) else { return }
        
        requestLogoutOrWithdrawal(urlResource: resource, socialToken: socialToken)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success:
                    KeychainManager.shared.removeAllKeys()
                    owner.output.accessToken.accept(KeychainManager.shared.read(for: .accessToken))
                    owner.output.isWithdrawalSuccess.accept(true)
                case .failure(let error):
                    owner.apiError.onNext(error)
            }
        })
        .disposed(by: bag)
    }
    
}


// MARK: - Networking - Record

extension MyPageVM {
    
    /// 완등 기록 조회 요청
    func requestGetRecord() {
        let path = "/api/climbing-records"
        let resource = URLResource<RecordListResponseModel>(path: path)
        
        apiSession.requestGet(urlResource: resource)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let data):
                    owner.output.recordList.accept(data)
                    owner.output.totalRecord.accept((data.climbedAltitude, data.climbingCnt))
                case .failure(let error):
                    owner.apiError.onNext(error)
                }
            })
            .disposed(by: bag)
    }
    
}


// MARK: - Networking - User Info

extension MyPageVM {
    
    /// 유저 프로필 조회 요청
    func requestGetUserInfo() {
        let path = "/api/users/profile"
        let resource = URLResource<UserInfoResponseModel>(path: path)
        
        apiSession.requestGet(urlResource: resource)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let data):
                    owner.output.userInfo.accept(data)
                case .failure(let error):
                    owner.apiError.onNext(error)
                }
            })
            .disposed(by: bag)
    }
    
}
