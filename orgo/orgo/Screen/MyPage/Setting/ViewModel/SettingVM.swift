//
//  SettingVM.swift
//  orgo
//
//  Created by 김태현 on 2023/09/12.
//

import RxSwift
import RxCocoa
import RxDataSources

class SettingVM: BaseViewModel {
    
    // MARK: - Variables and Properties
    
    var input = Input()
    var output = Output()
    
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    
    var bag = DisposeBag()
    
    struct Input {}
    struct Output {
        let accessToken = BehaviorRelay(value: KeychainManager.shared.read(for: .accessToken))
        var isAuthenticated: Observable<Bool> {
            accessToken.map { $0 != nil }
        }
        
        var settingMenu: Observable<Array<SettingMenu>> {
            isAuthenticated.map { $0 ? SettingMenu.authenticated : SettingMenu.unAuthenticated }
        }
        var settingMenuDataSource: Observable<Array<SettingMenuDataSource>> {
            settingMenu.map { [SettingMenuDataSource(items: $0)] }
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

extension SettingVM {
    func bindInput() {}
}

// MARK: - Output

extension SettingVM {
    func bindOutput() {}
}
