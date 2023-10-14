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


// MARK: - Network

extension BadgeListVM {
    
    func requestGetBadgeList() {
        let path = "/api/badges/acquired"
        let resource = URLResource<[BadgeResponseModel]>(path: path)
        
        apiSession.requestGet(urlResource: resource)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let data):
                    owner.updateDataSource(by: data)
                case .failure(let error):
                    print(error)
                }
            })
            .disposed(by: bag)
    }
    
    private func updateDataSource(by data: [BadgeResponseModel]) {
        let currentBadgeList = output.badgeList.value // 현재 뱃지 목록을 가져옵니다
        
        for newData in data {
            for category in currentBadgeList {
                for badge in category.items {
                    if badge.id == newData.id {
                        // 해당 ID를 가진 뱃지를 찾았습니다.
                        // 이제 해당 뱃지의 isCorrect 값을 newData에서 가져온 값으로 업데이트합니다.
                        dump(badge)
                        badge.isAcquired = true
                        print("here")
                    }
                }
            }
        }
        
        // 업데이트된 뱃지 목록을 BehaviorRelay에 반영합니다.
        output.badgeList.accept(currentBadgeList)
    }
}
