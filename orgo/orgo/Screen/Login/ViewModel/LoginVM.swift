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
import KakaoSDKCommon

class LoginVM: BaseViewModel {
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
    
    init() { }
    
    deinit {
        bag = DisposeBag()
    }
}
