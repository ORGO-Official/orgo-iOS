//
//  LoginVM.swift
//  orgo
//
//  Created by 김태현 on 2023/08/16.
//

import Foundation

import RxSwift
import RxCocoa

import Alamofire

import KakaoSDKAuth
import KakaoSDKUser

class LoginVM: BaseViewModel {
    
    // MARK: - Variables and Properties
    
    var input = Input()
    var output = Output()
    
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    
    var bag = DisposeBag()
    
    struct Input {}
    struct Output {
        var isLoginSuccess = PublishRelay<Bool>()
    }
    
    // MARK: - Life Cycle
    
    init() { }
    
    deinit {
        bag = DisposeBag()
    }
}


// MARK: - Input

extension LoginVM: Input {
    func bindInput() {}
}

// MARK: - Output

extension LoginVM: Output {
    func bindOutput() {}
}


// MARK: - Networking

extension LoginVM {
    
    func requestSocialLogin(loginType: LoginType, token: String) {
        let path = "/api/auth/login/\(loginType.description)"
        let resource = URLResource<LoginResponseModel>(path: path)
        
        requestSocialLogin(urlResource: resource, loginType: loginType, token: token)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let data):
                    KeychainManager.shared.save(key: .accessToken, value: data.accessToken)
                    KeychainManager.shared.save(key: .refreshToken, value: data.refreshToken)
                    KeychainManager.shared.save(key: .identifier, value: token)
                    
                    print("\(loginType.description) 로그인 성공")
                    
                    owner.output.isLoginSuccess.accept(true)
                    
                case .failure(let error):
                    owner.apiError.onNext(error)
                    owner.output.isLoginSuccess.accept(false)
            }
        })
        .disposed(by: bag)
    }
    
    private func requestSocialLogin<T: Decodable>(urlResource: URLResource<T>,
                                                  loginType: LoginType,
                                                  token: String) -> Observable<Result<T, APIError>> {
        Observable<Result<T, APIError>>.create { observer in
            var headers = HTTPHeaders()
            headers.add(.accept("*/*"))
            headers.add(name: "social", value: token)
            
            let task = AF.request(urlResource.resultURL,
                                  method: .post,
                                  encoding: JSONEncoding.default,
                                  headers: headers)
                .validate(statusCode: 200...399)
                .responseDecodable(of: T.self) { response in
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


// MARK: - 카카오 로그인

extension LoginVM {
    
    /// 카카오 로그인 api 호출
    func requestKakaoLogin() {
        switch UserApi.isKakaoTalkLoginAvailable() {
        case true:
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                guard let self = self else { return }
                
                if let oauthToken = oauthToken {
                    print("카카오톡 앱으로 로그인 성공")
                    self.requestSocialLogin(loginType: .kakao, token: oauthToken.accessToken)
                } else if let error = error {
                    print(error)
                }
            }
            
        case false:
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                guard let self = self else { return }
                
                if let oauthToken = oauthToken {
                    print("카카오톡 앱으로 로그인 성공")
                    self.requestSocialLogin(loginType: .kakao, token: oauthToken.accessToken)
                } else if let error = error {
                    print(error)
                }
            }
        }
    }
        
}
