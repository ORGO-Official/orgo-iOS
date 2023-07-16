//
//  BaseViewModel.swift
//  orgo
//
//  Created by 김태현 on 2023/07/16.
//

import RxSwift

protocol BaseViewModel: Input, Output {
    
    var apiSession: APIService { get }
    
    var bag: DisposeBag { get }
    
}
