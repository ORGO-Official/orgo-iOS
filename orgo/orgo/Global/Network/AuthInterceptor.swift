//
//  AuthInterceptor.swift
//  orgo
//
//  Created by 김태현 on 2023/08/16.
//

import RxSwift
import Alamofire

class AuthInterceptor: RequestInterceptor {
    
    // MARK: - Variables and Properties
    
    private let bag = DisposeBag()
    
    // MARK: - Functions
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let accessToken = KeychainManager.shared.read(for: .accessToken) else { return }
        
        var urlRequest = urlRequest
        urlRequest.headers.add(name: "auth", value: accessToken)
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // 토큰 만료 에러코드 401이 아닌 경우
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401
        else {
            // 시도하지 않고 종료
            completion(.doNotRetryWithError(error))
            return
        }
        
        APIToken.requestUpdateToken()
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(_):
                    completion(.retry)
                    
                case .failure(let error):
                    KeychainManager.shared.removeAllKeys()
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVCToLogin()
                    completion(.doNotRetryWithError(error))
                }
            })
            .disposed(by: bag)
    }
    
}

