//
//  RecordTVC.swift
//  orgo
//
//  Created by 김태현 on 2023/09/11.
//

import UIKit

import SnapKit
import Then

import RxSwift
import RxGesture
import RxCocoa

class RecordTVC: BaseTableViewCell {
    
    // MARK: - UI components
    
    let recordDateLabel: UILabel = UILabel()
        .then {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
        }
    
    let infoStackView: UIStackView = UIStackView()
        .then {
            $0.spacing = 4.0
            $0.distribution = .fill
            $0.alignment = .fill
            $0.axis = .vertical
        }
    
    let mountainNameLabel: UILabel = UILabel()
        .then {
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
        }
    
    let mountainHeightLabel: UILabel = UILabel()
        .then {
            $0.textColor = ColorAssets.gray
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(size: 13.0, weight: .regular)
        }
    
    let countLabel: UILabel = UILabel()
        .then {
            $0.textColor = .black
            $0.textAlignment = .center
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0))
    }
    
    // MARK: - Function
    
    // TODO: - 더미 데이터 수정
    func configureRecord(data: RecordResponseModel) {
        recordDateLabel.text = data.date
        mountainNameLabel.text = data.mountainName
        mountainHeightLabel.text = "해발 1억m"
        countLabel.text = "1억회차"
    }
    
}


// MARK: - Configure

extension RecordTVC {
    
    private func configureInnerView() {
        contentView.addSubviews([recordDateLabel,
                                 infoStackView,
                                 countLabel])
        
        [mountainNameLabel, mountainHeightLabel].forEach {
            infoStackView.addArrangedSubview($0)
        }
        
        backgroundColor = .white
        selectionStyle = .none
        contentView.backgroundColor = ColorAssets.lightGray
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true
    }
    
}


// MARK: - Layout

extension RecordTVC {
    
    private func configureLayout() {
        recordDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(20.0)
        }
        
        infoStackView.snp.makeConstraints {
            $0.center.equalTo(contentView)
            $0.width.equalTo(80.0)
        }
        
        [mountainNameLabel, mountainHeightLabel].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(16.0)
            }
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-24.0)
        }
    }
    
}
