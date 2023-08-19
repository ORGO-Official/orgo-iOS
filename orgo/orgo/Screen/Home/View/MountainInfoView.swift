//
//  MountainInfoView.swift
//  orgo
//
//  Created by 김태현 on 2023/08/19.
//

import UIKit

import SnapKit
import Then

class MountainInfoView: BaseView {
    
    // MARK: - UI components
    
    let leftStackView = UIStackView()
        .then {
            $0.spacing = 4.0
            $0.distribution = .fill
            $0.alignment = .leading
            $0.axis = .vertical
        }
    
    let rightStackView = UIStackView()
        .then {
            $0.spacing = 4.0
            $0.distribution = .fill
            $0.alignment = .leading
            $0.axis = .vertical
        }
    
    let mountainName = UILabel()
        .then {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 20.0, weight: .medium)
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
        mountainName.text = mountainInfo.name
        address.text = mountainInfo.address
        altitude.text = "\(Int(mountainInfo.location.altitude))m"
        requiredTime.text = "데이터 필요"
        contact.text = mountainInfo.contact
    }
    
}


// MARK: - Configure

extension MountainInfoView {
    
    private func configureInnerView() {
        addSubviews([leftStackView, rightStackView, mountainName])
        
        [addressTitle, altitudeTitle, requiredTimeTitle, contactTitle].forEach {
            leftStackView.addArrangedSubview($0)
        }
        
        [address, altitude, requiredTime, contact].forEach {
            rightStackView.addArrangedSubview($0)
        }
    }
    
}


// MARK: - Layout

extension MountainInfoView {
    
    private func configureLayout() {
        mountainName.snp.makeConstraints {
            $0.top.leading.equalTo(self)
            $0.height.equalTo(28.0)
            $0.width.equalTo(60.0)
        }
        
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
            $0.top.equalTo(mountainName.snp.bottom).offset(16.0)
            $0.leading.equalTo(self)
            $0.width.equalTo(60.0)
        }

        rightStackView.snp.makeConstraints {
            $0.top.equalTo(leftStackView.snp.top)
            $0.leading.equalTo(leftStackView.snp.trailing).offset(12.0)
            $0.trailing.equalTo(self)
        }
    }
    
}
