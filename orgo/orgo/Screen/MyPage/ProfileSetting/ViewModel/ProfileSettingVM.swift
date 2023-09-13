//
//  ProfileSettingVM.swift
//  orgo
//
//  Created by 김태현 on 2023/09/14.
//

import Foundation

import RxSwift
import RxCocoa

import Alamofire

final class ProfileSettingVM: BaseViewModel {
    
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
        
        var isModifySuccess = PublishRelay<Bool>()
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

extension ProfileSettingVM {
    func bindInput() {}
}

// MARK: - Output

extension ProfileSettingVM {
    func bindOutput() {}
}


// MARK: - Networking - 프로필 수정

extension ProfileSettingVM {
    
    /// 프로필 수정 요청
    func requestPutUserInfo(nickname: String, email: String, profileImage: UIImage) {
        let path = "/api/users/profile"
        let resource = URLResource<EmptyResponseModel>(path: path)
        guard let nicknameData = try? JSONSerialization.data(withJSONObject: ["nickname" : nickname]) else { return }
        
        requestPutUserInfo(urlResource: resource, nicknameData: nicknameData, image: profileImage)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success:
                    owner.output.isModifySuccess.accept(true)
                case .failure(let error):
                    owner.apiError.onNext(error)
                }
            })
            .disposed(by: bag)
    }
    
    private func requestPutUserInfo<T: Decodable>(urlResource: URLResource<T>, nicknameData: Data, image: UIImage) -> Observable<Result<T, APIError>> {
        Observable<Result<T, APIError>>.create { observer in
            var headers = HTTPHeaders()
            headers.add(.accept("*/*"))
            headers.add(.contentType("multipart/form-data"))
            
            let task = AF.upload(multipartFormData: { (multipart) in
                multipart.append(nicknameData, withName: "requestDto", mimeType: "application/json")
                if let imageData = image.jpegData(compressionQuality: 1) {
                    multipart.append(imageData, withName: "imageFile", fileName: "profile.jpeg", mimeType: "image/jpeg")
                }
            }, to: urlResource.resultURL,
                                 method: .put,
                                 headers: headers,
                                 interceptor: AuthInterceptor())
                .validate(statusCode: 200...399)
                .responseDecodable(of: T.self) { response in
                    debugPrint(response)
                    switch response.result {
                    case .success(let data):
                        observer.onNext(.success(data))
                    case .failure:
                        observer.onNext(urlResource.judgeError(statusCode: response.response?.statusCode ?? -1))
                    }
                }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
}
