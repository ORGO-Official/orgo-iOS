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
    
    let mainImageView: UIImageView = UIImageView()
        .then {
            $0.image = ImageAssets.orgoBackground
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 16.0
            $0.clipsToBounds = true
        }
    
    let orgoLogoImageView: UIImageView = UIImageView()
        .then {
            $0.image = ImageAssets.todayOrgoLogo
        }
    
    let orgoWaterMarkImageView: UIImageView = UIImageView()
        .then {
            $0.image = ImageAssets.orgoLogoWhite
        }
    
    let dimmedView: UIView = UIView()
        .then {
            $0.backgroundColor = .black.withAlphaComponent(0.1)
        }
    
    let bottomMenuView: UIView = UIView()
        .then {
            $0.backgroundColor = .black
        }
    
    let buttonStackView: UIStackView = UIStackView()
        .then {
            $0.axis = .horizontal
            $0.spacing = 14.0
            $0.alignment = .fill
            $0.distribution = .fill
        }
    
    let photoSelectBtn: UIButton = UIButton(type: .system)
        .then {
            $0.setTitle("사진 선택", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(size: 15.0, weight: .bold)
            $0.tintColor = .white
            
            $0.backgroundColor = .clear
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 2.0
            $0.layer.cornerRadius = 20.0
        }
    
    let shareBtn: UIButton = UIButton(type: .system)
        .then {
            $0.setTitle("공유", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(size: 15.0, weight: .bold)
            $0.tintColor = .white
            
            $0.backgroundColor = .clear
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 2.0
            $0.layer.cornerRadius = 20.0
        }
    
    let saveBtn: UIButton = UIButton(type: .system)
        .then {
            $0.setImage(ImageAssets.saveButton, for: .normal)
        }
    
    let confirmBtn: UIButton = UIButton(type: .system)
        .then {
            $0.setImage(ImageAssets.confirmButton, for: .normal)
            $0.layer.cornerRadius = 20.0
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
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy.MM.dd"
//        let currentDateString = dateFormatter.string(from: Date())
//
//        dateLabel.text = currentDateString
//        lowerLabel.text = "\(data.name) 완등 완료"
//        heightLabel.text = "해발 \(data.location.altitude)m"
    }
}


// MARK: - Configure

extension RecordCompletionVC {
    
    private func configureInnerView() {
        view.backgroundColor = .black
        
        view.addSubviews([mainImageView,
                          bottomMenuView])
        
        mainImageView.addSubviews([dimmedView])
        
        dimmedView.addSubviews([orgoLogoImageView,
                                orgoWaterMarkImageView])
        
        bottomMenuView.addSubviews([buttonStackView,
                                    saveBtn,
                                    confirmBtn])
        
        [photoSelectBtn,
         shareBtn].forEach {
            buttonStackView.addArrangedSubview($0)
        }
    }
    
}


// MARK: - Layout

extension RecordCompletionVC {
    
    private func configureLayout() {
        bottomMenuView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(50.0)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(18.0)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(39.0)
        }
        
        photoSelectBtn.snp.makeConstraints {
            $0.width.equalTo(88.0)
        }
        
        shareBtn.snp.makeConstraints {
            $0.width.equalTo(88.0)
        }
        
        saveBtn.snp.makeConstraints {
            $0.leading.equalTo(buttonStackView.snp.trailing).offset(18.0)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24.0)
        }
        
        confirmBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-18.0)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(40.0)
        }
        
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomMenuView.snp.top)
        }
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        orgoLogoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(86.0)
            $0.height.equalTo(orgoLogoImageView.snp.width).dividedBy(2.47)
        }
        
        orgoWaterMarkImageView.snp.makeConstraints {
            $0.width.equalTo(46.0)
            $0.height.equalTo(23.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-15.0)
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
        
        photoSelectBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                print("TODO: - 사진 선택")
            })
            .disposed(by: bag)
        
        shareBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                print("TODO: - 공유")
            })
            .disposed(by: bag)
        
        saveBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                print("TODO: - 저장")
            })
            .disposed(by: bag)
    }
    
}
