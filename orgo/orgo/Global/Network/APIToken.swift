//
//  APIToken.swift
//  orgo
//
//  Created by 김태현 on 2023/08/16.
//

import RxSwift
import Alamofire

import KakaoSDKAuth

import NaverThirdPartyLogin

struct APIToken {
    
    static func requestUpdateToken() -> Observable<Result<Bool, APIError>> {
        Observable<Result<Bool, APIError>>.create { observer in
            guard let accessToken = KeychainManager.shared.read(for: .accessToken),
                  let refreshToken = KeychainManager.shared.read(for: .refreshToken)
            else {
                observer.onNext(.failure(.unable))
                return Disposables.create()
            }
            
            var headers = HTTPHeaders()
            headers.add(.accept("*/*"))
            headers.add(name: "auth", value: accessToken)
            headers.add(name: "refresh", value: refreshToken)
            
            let path = "/api/auth/reissue"
            let urlResource = URLResource<Bool>(path: path)
            
            let task = AF.request(urlResource.resultURL,
                                  method: .post,
                                  encoding: URLEncoding.default,
                                  headers: headers)
                .validate(statusCode: 200...399)
                .responseString { response in
                    switch response.result {
                    case .success(let data):
                        KeychainManager.shared.refresh(accessToken: data)
                        observer.onNext(.success(true))
                    case .failure:
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


// MARK: - 소셜 로그인 토큰 갱신

extension APIToken {
    
    static func refreshSocialToken() {
        guard let loginType = KeychainManager.shared.read(for: .loginType) else { return }
        
        switch loginType {
        case "kakao":
            refreshKakaoToken()
        case "naver":
            refreshNaverToken()
        case "apple":
            break
        default:
            fatalError()
        }
    }
    
    private static func refreshKakaoToken() {
        AuthApi.shared.refreshToken { oauthToken, error in
            if let oauthToken = oauthToken {
                KeychainManager.shared.save(key: .identifier, value: oauthToken.accessToken)
            } else if let error = error {
                print(error)
            }
        }
    }
    
    private static func refreshNaverToken() {
        guard let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance() else { return }
        naverLoginInstance.requestAccessTokenWithRefreshToken()
        KeychainManager.shared.save(key: .identifier, value: naverLoginInstance.accessToken)
    }
    
}
