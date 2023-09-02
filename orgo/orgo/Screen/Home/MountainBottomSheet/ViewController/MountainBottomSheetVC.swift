//
//  MountainBottomSheetVC.swift
//  orgo
//
//  Created by 김태현 on 2023/08/19.
//

import UIKit

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
    
    
    // MARK: - Variables and Properties
    
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
    }
    
    // MARK: - Functions
    
    func configureInfo(from mountainInfo: MountainListResponseModel) {
        mountainInfoView.configureInfo(from: mountainInfo)
        mountainInformation = mountainInfo
    }
}


// MARK: - Configure

extension MountainBottomSheetVC {
    
    private func configureBottomSheet() {
        view.addSubviews([mountainInfoView, authenticateBtn])
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
    
}
