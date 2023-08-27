//
//  MountainDetailInfoView.swift
//  orgo
//
//  Created by 김태현 on 2023/08/28.
//

import UIKit

import SnapKit
import Then

class MountainDetailInfoView: BaseView {
    
    // MARK: - UI components
    
    let leftStackView = UIStackView()
        .then {
            $0.spacing = 8.0
            $0.distribution = .fill
            $0.alignment = .leading
            $0.axis = .vertical
        }
    
    let rightStackView = UIStackView()
        .then {
            $0.spacing = 8.0
            $0.distribution = .fill
            $0.alignment = .leading
            $0.axis = .vertical
        }
    
    let addressTitle = UILabel()
        .then {
            $0.text = "주소"
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
        }
    
    let altitudeTitle = UILabel()
        .then {
            $0.text = "고도"
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
        }
    
    let requiredTimeTitle = UILabel()
        .then {
            $0.text = "완등 시간"
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
        }
    
    let contactTitle = UILabel()
        .then {
            $0.text = "문의"
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
        }
    
    let address = UILabel()
        .then {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
        }
    
    let altitude = UILabel()
        .then {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
        }

    let requiredTime = UILabel()
        .then {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
        }
    
    let contact = UILabel()
        .then {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
        }
    
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
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
        address.text = mountainInfo.address
        altitude.text = "\(Int(mountainInfo.location.altitude))m"
        requiredTime.text = mountainInfo.requiredTime
        contact.text = mountainInfo.contact
    }
    
}


// MARK: - Configure

extension MountainDetailInfoView {
    
    private func configureInnerView() {
        addSubviews([leftStackView, rightStackView])
        
        [addressTitle, altitudeTitle, requiredTimeTitle, contactTitle].forEach {
            leftStackView.addArrangedSubview($0)
        }
        
        [address, altitude, requiredTime, contact].forEach {
            rightStackView.addArrangedSubview($0)
        }
    }
    
}


// MARK: - Layout

extension MountainDetailInfoView {
    
    private func configureLayout() {
        [addressTitle, altitudeTitle, requiredTimeTitle, contactTitle].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(20.0)
            }
        }
        
        [address, altitude, requiredTime, contact].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(20.0)
            }
        }

        leftStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16.0)
            $0.leading.equalTo(self)
            $0.width.equalTo(60.0)
        }

        rightStackView.snp.makeConstraints {
            $0.top.equalTo(leftStackView.snp.top)
            $0.leading.equalTo(leftStackView.snp.trailing).offset(56.0)
            $0.trailing.equalTo(self)
        }
    }
    
}

