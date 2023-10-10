//
//  RecordCompletionVC.swift
//  orgo
//
//  Created by 김태현 on 2023/09/17.
//

import Foundation
import PhotosUI

import RxSwift
import RxCocoa
import RxGesture

import Then
import SnapKit

class RecordCompletionVC: BaseViewController {
    
    // MARK: - UI components
    
    private let mainImageView: UIImageView = UIImageView()
        .then {
            $0.isUserInteractionEnabled = true
            $0.image = ImageAssets.orgoBackground
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 16.0
            $0.clipsToBounds = true
        }
    
    private let orgoLogoImageView: UIImageView = UIImageView()
        .then {
            $0.image = ImageAssets.todayOrgoLogo
        }
    
    private let orgoWaterMarkImageView: UIImageView = UIImageView()
        .then {
            $0.image = ImageAssets.orgoLogoWhite
        }
    
    private let dimmedView: UIView = UIView()
        .then {
            $0.isUserInteractionEnabled = true
            $0.backgroundColor = .black.withAlphaComponent(0.1)
        }
    
    private let mountainNameBtn: MountainButton = MountainButton()
    
    private let infoStackView: UIStackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.spacing = 6.0
            $0.alignment = .fill
            $0.distribution = .fill
        }
    
    private let altitudeLabel: UILabel = UILabel()
        .then {
            $0.text = "000m"
            $0.font = UIFont.pretendard(size: 15.0, weight: .bold)
            $0.textColor = .white
            $0.textAlignment = .left
        }
    
    private let timeLabel: UILabel = UILabel()
        .then {
            $0.text = "00:00:00"
            $0.font = UIFont.pretendard(size: 15.0, weight: .bold)
            $0.textColor = .white
            $0.textAlignment = .left
        }
    
    private let dateLabel: UILabel = UILabel()
        .then {
            $0.text = "0000.00.00"
            $0.font = UIFont.pretendard(size: 15.0, weight: .bold)
            $0.textColor = .white
            $0.textAlignment = .left
        }
    
    private let bottomMenuView: UIView = UIView()
        .then {
            $0.backgroundColor = .black
        }
    
    private let buttonStackView: UIStackView = UIStackView()
        .then {
            $0.axis = .horizontal
            $0.spacing = 14.0
            $0.alignment = .fill
            $0.distribution = .fill
        }
    
    private let photoSelectBtn: UIButton = UIButton(type: .system)
        .then {
            $0.setTitle("사진 선택", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(size: 15.0, weight: .bold)
            $0.tintColor = .white
            
            $0.backgroundColor = .clear
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 2.0
            $0.layer.cornerRadius = 20.0
        }
    
    private let shareBtn: UIButton = UIButton(type: .system)
        .then {
            $0.setTitle("공유", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(size: 15.0, weight: .bold)
            $0.tintColor = .white
            
            $0.backgroundColor = .clear
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 2.0
            $0.layer.cornerRadius = 20.0
        }
    
    private let saveBtn: UIButton = UIButton(type: .system)
        .then {
            $0.setImage(ImageAssets.saveButton, for: .normal)
        }
    
    private let confirmBtn: UIButton = UIButton(type: .system)
        .then {
            $0.setImage(ImageAssets.confirmButton, for: .normal)
            $0.layer.cornerRadius = 20.0
        }
    
    private let photoSelectMenuBox: MenuBoxView = MenuBoxView(type: .photoSelect)
        .then {
            $0.isHidden = true
        }
    
    private let shareMenuBox: MenuBoxView = MenuBoxView(type: .share)
        .then {
            $0.isHidden = true
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
        mountainNameBtn.setButton(name: "계양산")
    }
    
    private func hideMenuBox() {
        photoSelectMenuBox.isHidden = true
        shareMenuBox.isHidden = true
    }
    
    private func openGallery() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    private func openCamera() {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .camera
        pickerController.cameraDevice = .rear
        pickerController.showsCameraControls = true
        pickerController.delegate = self
        
        present(pickerController, animated: true)
    }
    
    private func setMainImage(by image: UIImage) {
        mainImageView.image = image
        orgoLogoImageView.isHidden = true
    }
    
    private func shareToInstagram() {
        guard let pngImageData = mainImageView.capture().pngData(),
              let appId = Bundle.main.object(forInfoDictionaryKey: "INSTAGRAM_APP_ID") as? String,
              let url = URL(string: "instagram-stories://share?source_application=\(appId)") else { return }
        
        let pasteboardItems: [String: Any] = ["com.instagram.sharedSticker.backgroundImage": pngImageData]
        let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)]
        
        UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("TODO: - 인스타그램이 없을때 처리")
        }
    }
    
    private func presentActivityVC() {
        let capturedImage = mainImageView.capture()
        let activityVC = UIActivityViewController(activityItems: [capturedImage], applicationActivities: nil)
        activityVC.excludedActivityTypes = [.addToReadingList,
                                            .print,
                                            .assignToContact,
                                            .openInIBooks,
                                            .postToFlickr,
                                            .postToWeibo,
                                            .postToVimeo,
                                            .postToTencentWeibo]
        activityVC.popoverPresentationController?.sourceView = self.view
        present(activityVC, animated: true)
    }
    
}


// MARK: - Configure

extension RecordCompletionVC {
    
    private func configureInnerView() {
        view.backgroundColor = .black
        
        view.addSubviews([mainImageView,
                          bottomMenuView,
                          photoSelectMenuBox,
                          shareMenuBox])
        
        mainImageView.addSubviews([dimmedView])
        
        dimmedView.addSubviews([mountainNameBtn,
                                infoStackView,
                                orgoLogoImageView,
                                orgoWaterMarkImageView])
        
        [altitudeLabel, timeLabel, dateLabel].forEach {
            infoStackView.addArrangedSubview($0)
        }
        
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
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
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
        
        mountainNameBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(45.0)
            $0.leading.equalToSuperview().offset(19.0)
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(mountainNameBtn.snp.top).offset(70.0)
            $0.leading.equalToSuperview().offset(36.0)
            $0.trailing.equalToSuperview().offset(-36.0)
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
        
        photoSelectMenuBox.snp.makeConstraints {
            $0.leading.equalTo(photoSelectBtn.snp.leading)
            $0.bottom.equalTo(bottomMenuView.snp.top).offset(-16.0)
            $0.height.equalTo(127.0)
            $0.width.equalTo(210.0)
        }
        
        shareMenuBox.snp.makeConstraints {
            $0.leading.equalTo(shareBtn.snp.leading)
            $0.bottom.equalTo(bottomMenuView.snp.top).offset(-16.0)
            $0.height.equalTo(127.0)
            $0.width.equalTo(236.0)
        }
    }
    
}


// MARK: - Input

extension RecordCompletionVC {
    
    private func bindBtn() {
        confirmBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.hideMenuBox()
                owner.dismiss(animated: true)
            })
            .disposed(by: bag)
        
        photoSelectBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.photoSelectMenuBox.isHidden.toggle()
                owner.shareMenuBox.isHidden = true
            })
            .disposed(by: bag)
        
        shareBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.shareMenuBox.isHidden.toggle()
                owner.photoSelectMenuBox.isHidden = true
            })
            .disposed(by: bag)
        
        photoSelectMenuBox.upperTapArea.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.openGallery()
            })
            .disposed(by: bag)
        
        photoSelectMenuBox.lowerTapArea.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.openCamera()
            })
            .disposed(by: bag)
        
        shareMenuBox.upperTapArea.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.shareToInstagram()
            })
            .disposed(by: bag)
        
        shareMenuBox.lowerTapArea.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.presentActivityVC()
            })
            .disposed(by: bag)
        
        saveBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.presentActivityVC()
                owner.hideMenuBox()
            })
            .disposed(by: bag)
        
        view.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.hideMenuBox()
            })
            .disposed(by: bag)
        
        mountainNameBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.mountainNameBtn.isSelected.toggle()
            })
            .disposed(by: bag)
    }
    
}


// MARK: - PHPickerViewControllerDelegate

extension RecordCompletionVC: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let itemProvider = results.first?.itemProvider,
              itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
        
        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] loadedImage, error in
            guard let self = self,
                  let image = loadedImage as? UIImage else { return }
            
            DispatchQueue.main.async {
                self.setMainImage(by: image)
            }
        }
    }
    
}


// MARK: - UIImagePickerControllerDelegate

extension RecordCompletionVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let photoImage = info[.originalImage] as? UIImage else { return }
        
        setMainImage(by: photoImage)
    }
    
}
