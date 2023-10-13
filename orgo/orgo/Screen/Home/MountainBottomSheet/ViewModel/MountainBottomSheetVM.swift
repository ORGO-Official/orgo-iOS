//
//  MountainBottomSheetVM.swift
//  orgo
//
//  Created by 김태현 on 2023/09/17.
//

import RxCocoa
import RxSwift

import CoreLocation

final class MountainBottomSheetVM: BaseViewModel {
    
    // MARK: - Variables and Properties
    
    var input = Input()
    var output = Output()
    
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    
    var bag = DisposeBag()
    
    struct Input {}
    struct Output {
        var isRecordSuccess = PublishRelay<Bool>()
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

extension MountainBottomSheetVM: Input {
    func bindInput() {}
}

// MARK: - Output

extension MountainBottomSheetVM: Output {
    func bindOutput() {}
}

// MARK: - Networking

extension MountainBottomSheetVM {
    
    func requestPostMountainRecord(id: Int, location: CLLocation) {
        let path = "/api/climbing-records"
        let resource = URLResource<EmptyResponseModel>(path: path)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDateString = dateFormatter.string(from: Date())
            .split(separator: " ")
            .joined(separator: "T")
        
        let mountainRecord = MountainRecordRequestModel(mountainId: id,
                                                        latitude: location.coordinate.latitude,
                                                        longitude: location.coordinate.longitude,
                                                        altitude: location.altitude,
                                                        date: currentDateString)
        
        apiSession.requestPost(urlResource: resource, parameter: mountainRecord.parameter)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success:
                    owner.output.isRecordSuccess.accept(true)
                case .failure(let error):
                    owner.output.isRecordSuccess.accept(false)
                    print(error)
                }
            })
            .disposed(by: bag)
    }
    
}
