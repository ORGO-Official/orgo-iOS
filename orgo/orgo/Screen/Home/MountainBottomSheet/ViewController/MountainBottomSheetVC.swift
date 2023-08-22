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
    
    
    // MARK: - Variables and Properties
    
    
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
    
    // MARK: - Functions
    
    func configureInfo(from mountainInfo: MountainListResponseModel) {
        mountainInfoView.configureInfo(from: mountainInfo)
    }
}


// MARK: - Configure

extension MountainBottomSheetVC {
    
    private func configureBottomSheet() {
        view.addSubviews([mountainInfoView])
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
    }
    
}
