//
//  RecordCompletionVC.swift
//  orgo
//
//  Created by 김태현 on 2023/09/17.
//

import Foundation

import RxSwift
import RxCocoa
import RxGesture

import Then
import SnapKit

class RecordCompletionVC: BaseViewController {
    
    // MARK: - UI components
    
    let dateLabel: UILabel = UILabel()
        .then {
            $0.font = UIFont.pretendard(size: 14.0, weight: .regular)
            $0.textAlignment = .left
            $0.textColor = .white
        }
    
    let completeImageView: UIImageView = UIImageView()
        .then {
            $0.image = ImageAssets.climbCompleteLogo
            $0.contentMode = .scaleAspectFit
        }
    
    let upperTitle: UILabel = UILabel()
        .then {
            $0.text = "축하드립니다!"
            $0.font = UIFont.pretendard(size: 20.0, weight: .medium)
            $0.textAlignment = .center
            $0.textColor = .white
        }
    
    let lowerLabel: UILabel = UILabel()
        .then {
            $0.font = UIFont.pretendard(size: 20.0, weight: .medium)
            $0.textAlignment = .center
            $0.textColor = .white
        }
    
    let heightLabel: UILabel = UILabel()
        .then {
            $0.font = UIFont.pretendard(size: 13.0, weight: .regular)
            $0.textAlignment = .center
            $0.textColor = .white
        }
    
    let confirmBtn: UIButton = UIButton()
        .then {
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(size: 14.0, weight: .bold)
            
            $0.setBackgroundColor(.systemBlue, for: .normal)
            
            $0.layer.cornerRadius = 5.0
            $0.layer.masksToBounds = true
        }
    
    
    // MARK: - Variables and Properties
    
    
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
    
    override func bindInput() {
        super.bindInput()
        
        bindBtn()
    }
    
    // MARK: - Functions
    
    func configureInfo(data: MountainListResponseModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let currentDateString = dateFormatter.string(from: Date())
        
        dateLabel.text = currentDateString
        lowerLabel.text = "\(data.name) 완등 완료"
        heightLabel.text = "해발 \(data.location.altitude)m"
    }
}


// MARK: - Configure

extension RecordCompletionVC {
    
    private func configureInnerView() {
        view.backgroundColor = ColorAssets.mainGreen
        
        view.addSubviews([dateLabel,
                          completeImageView,
                          upperTitle,
                          lowerLabel,
                          heightLabel,
                          confirmBtn])
    }
    
}


// MARK: - Layout

extension RecordCompletionVC {
    
    private func configureLayout() {
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        completeImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(screenHeight / 3.5)
            $0.leading.trailing.equalToSuperview().inset(90.0)
            $0.height.equalTo(completeImageView.snp.width).dividedBy(2.4)
        }
        
        upperTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(completeImageView.snp.bottom).offset(screenHeight / 5.2)
        }
        
        lowerLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(upperTitle.snp.bottom).offset(4.0)
        }
        
        heightLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(lowerLabel.snp.bottom).offset(4.0)
        }
        
        confirmBtn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().offset(-45.0)
            $0.height.equalTo(36.0)
        }
    }
    
}


// MARK: - Input

extension RecordCompletionVC {
    
    private func bindBtn() {
        confirmBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.dismiss(animated: true)
            })
            .disposed(by: bag)
    }
    
}
