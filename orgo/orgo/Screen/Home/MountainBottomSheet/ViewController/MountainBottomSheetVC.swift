//
//  MountainBottomSheetVC.swift
//  orgo
//
//  Created by 김태현 on 2023/08/19.
//

import UIKit
import CoreLocation

import SnapKit
import Then

import RxSwift
import RxGesture
import RxCocoa

class MountainBottomSheetVC: OrgoBottomSheet {
    
    // MARK: - UI components
    
    let mountainInfoView: MountainInfoView = MountainInfoView()
    
    private let authenticateBtn = UIButton(type: .system)
        .then {
            $0.titleLabel?.font = UIFont.pretendard(size: 14.0, weight: .bold)
            $0.setTitle("완등 인증하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.setTitleColor(.gray, for: .disabled)
            
            $0.setBackgroundColor(ColorAssets.mainGreen, for: .normal)
            $0.setBackgroundColor(.lightGray, for: .disabled)
            
            $0.layer.cornerRadius = 5.0
            $0.layer.masksToBounds = true
        }
    
    private let authenticateLabel: UILabel = UILabel()
        .then {
            $0.text = "오르GO! 렛츠GO!"
            $0.font = UIFont.pretendard(size: 13.0, weight: .regular)
            $0.textAlignment = .center
            $0.textColor = ColorAssets.gray
        }
    
    
    // MARK: - Variables and Properties
    
    private let viewModel: MountainBottomSheetVM = MountainBottomSheetVM()
    private let locationManager: CLLocationManager = CLLocationManager()
    var mountainInformation: MountainListResponseModel?
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        super.configureView()
        
        configureBottomSheet()
    }
    
    override func layoutView() {
        super.layoutView()
        
        configureBottomSheetLayout()
    }
    
    override func bindInput() {
        super.bindInput()
        
        bindTap()
        bindBtn()
    }
    
    override func bindOutput() {
        super.bindOutput()
        
        bindRecordSuccess()
    }
    
    
    // MARK: - Functions
    
    func configureInfo(from mountainInfo: MountainListResponseModel) {
        mountainInfoView.configureInfo(from: mountainInfo)
        mountainInformation = mountainInfo
    }
    
    func requestCurrentLocation() {
        let authorization = locationManager.authorizationStatus
        
        switch authorization {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
            requestPostMountainRecord()
        case .notDetermined, .restricted:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func requestPostMountainRecord() {
        guard let mountainInformation = mountainInformation,
              let location = locationManager.location else { return }
        
        viewModel.requestPostMountainRecord(id: mountainInformation.id,
                                                  location: location)
    }
}


// MARK: - Configure

extension MountainBottomSheetVC {
    
    private func configureBottomSheet() {
        view.addSubviews([mountainInfoView,
                          authenticateBtn,
                          authenticateLabel])
        
        locationManager.delegate = self
    }
    
}


// MARK: - Layout

extension MountainBottomSheetVC {
 
    private func configureBottomSheetLayout() {
        mountainInfoView.snp.makeConstraints {
            $0.leading.equalTo(bottomSheetView.snp.leading).offset(16.0)
            $0.trailing.equalTo(bottomSheetView.snp.trailing).offset(-16.0)
            $0.top.equalTo(bottomSheetView.snp.top).offset(28.0)
        }
        
        authenticateBtn.snp.makeConstraints {
            $0.top.equalTo(bottomSheetView.snp.top).offset(182.0)
            $0.leading.equalTo(bottomSheetView.snp.leading).offset(16.0)
            $0.trailing.equalTo(bottomSheetView.snp.trailing).offset(-16.0)
            $0.height.equalTo(36.0)
        }
        
        authenticateLabel.snp.makeConstraints {
            $0.top.equalTo(authenticateBtn.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
        }
    }
    
}

// MARK: - Input

extension MountainBottomSheetVC {
    
    private func bindTap() {
        bottomSheetView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let mountainDetailVC = MountainDetailVC()
                
                if let mountainInfo = owner.mountainInformation {
                    mountainDetailVC.configureInfo(from: mountainInfo)
                }
                
                owner.navigationController?.pushViewController(mountainDetailVC, animated: true)
            })
            .disposed(by: bag)
    }
    
    private func bindBtn() {
        authenticateBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.requestCurrentLocation()
            })
            .disposed(by: bag)
    }
    
}


// MARK: - Output

extension MountainBottomSheetVC {
    
    private func bindRecordSuccess() {
        viewModel.output.isRecordSuccess
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isRecordSuccess in
                guard let self = self,
                      let mountainInformation = mountainInformation else { return }
                
                if isRecordSuccess {
                    print("성공")
                } else {
                    print("실패")
                }
                let recordCompletionVC = RecordCompletionVC()
                recordCompletionVC.modalPresentationStyle = .fullScreen
                recordCompletionVC.configureInfo(data: mountainInformation)
                self.present(recordCompletionVC, animated: true)
            })
            .disposed(by: bag)
    }
    
}

// MARK: - CLLocationManagerDelegate

extension MountainBottomSheetVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
