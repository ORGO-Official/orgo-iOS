//
//  BadgeListVM.swift
//  orgo
//
//  Created by 김태현 on 2023/10/14.
//

import Foundation

import RxSwift
import RxCocoa

import Alamofire

final class BadgeListVM: BaseViewModel {
    
    // MARK: - Variables and Properties
    
    var input = Input()
    var output = Output()
    
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    
    var bag = DisposeBag()
    
    struct Input {}
    struct Output {
        var badgeList: BehaviorRelay<Array<BadgeCategory>> = BehaviorRelay(value: BadgeCategory.allCases)
        var badgeListDataSource: Observable<Array<BadgeListDataSource>> {
            badgeList.map { $0.map { BadgeListDataSource(header: $0.rawValue, items: $0.items) } }
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

extension BadgeListVM {
    func bindInput() {}
}

// MARK: - Output

extension BadgeListVM {
    func bindOutput() {}
}
