//
//  MountainDetailVC.swift
//  orgo
//
//  Created by 김태현 on 2023/08/21.
//

import Foundation

import RxSwift
import RxCocoa

import Then
import SnapKit

class MountainDetailVC: BaseNavigationViewController {
    
    // MARK: - UI components
    
    let backgroundImageView = UIImageView()
        .then {
            $0.contentMode = .scaleToFill
        }
    
    let mainImageView = UIImageView()
        .then {
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 48.0
            $0.layer.masksToBounds = true
        }
    
    let mountainInfoView: MountainDetailInfoView = MountainDetailInfoView()
    
    let upperBorder = UIView()
        .then {
            $0.layer.cornerRadius = 1.0
            $0.backgroundColor = .lightGray
        }
    
    let lowerBorder = UIView()
        .then {
            $0.layer.cornerRadius = 1.0
            $0.backgroundColor = .lightGray
        }
    
    
    // MARK: - Variables and Properties
    
    private let viewModel: MountainDetailVM = MountainDetailVM()
    
    var mountainInformation: MountainListResponseModel?
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        super.configureView()
        
        configureInnerView()
    }
    
    override func layoutView() {
        super.layoutView()
        
        configureLayout()
    }
    
    // MARK: - Functions
    
    func configureInfo(from mountainInfo: MountainListResponseModel) {
        backgroundImageView.setImage(with: mountainInfo.backgroundImage)
        mainImageView.setImage(with: mountainInfo.mainImage)
        mountainInfoView.configureInfo(from: mountainInfo)
        
        mountainInformation = mountainInfo
        viewModel.requestGetRestaurantList(mountainId: mountainInfo.id)
    }
    
}


// MARK: - Configure

extension MountainDetailVC {
    
    private func configureInnerView() {
        title = mountainInformation?.name
        navigationBar.style = .left
        
        view.addSubviews([backgroundImageView,
                          mainImageView,
                          mountainInfoView,
                          upperBorder,
                          lowerBorder])
    }
    
}


// MARK: - Layout

extension MountainDetailVC {
    
    private func configureLayout() {
        backgroundImageView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalToSuperview().dividedBy(2.8)
        }
        
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(screenHeight / 4.0)
            $0.height.width.equalTo(screenHeight / 7.0)
            $0.centerX.equalToSuperview()
        }
        
        mountainInfoView.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(28.0)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16.0)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16.0)
            $0.height.equalTo(104.0)
        }
        
        upperBorder.snp.makeConstraints {
            $0.top.equalTo(mountainInfoView.snp.bottom).offset(16.0)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16.0)
            $0.height.equalTo(1.0)
        }
        
    }
    
}
