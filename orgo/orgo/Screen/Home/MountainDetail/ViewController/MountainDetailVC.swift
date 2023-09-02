//
//  MountainDetailVC.swift
//  orgo
//
//  Created by 김태현 on 2023/08/21.
//

import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import SafariServices

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
    
    let restaurantCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8.0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
                
        return collectionView
    }()
    
    
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
    
    override func bindOutput() {
        super.bindOutput()
        
        bindRestaurantList()
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
                          lowerBorder,
                          restaurantCV])
        
        restaurantCV.backgroundColor = .white
        restaurantCV.register(RestaurantCVC.self, forCellWithReuseIdentifier: RestaurantCVC.className)
        restaurantCV.delegate = self
        restaurantCV.dataSource = self
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
        
        lowerBorder.snp.makeConstraints {
            $0.top.equalTo(upperBorder.snp.bottom).offset(screenHeight / 9.5)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16.0)
            $0.height.equalTo(1.0)
        }
        
        restaurantCV.snp.makeConstraints {
            $0.top.equalTo(lowerBorder.snp.bottom).offset(12.0)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
}

// MARK: - Output

extension MountainDetailVC {
    
    private func bindRestaurantList() {
        viewModel.output.restaurantList
            .filter({ !$0.isEmpty })
            .withUnretained(self)
            .subscribe { owner, restaurantList in
                print(restaurantList)
                owner.restaurantCV.reloadData()
            }
            .disposed(by: bag)
    }
    
}


// MARK: - UICollectionViewDelegate

extension MountainDetailVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let restaurantList = viewModel.output.restaurantList.value
        
        if let restaurantInfoURL = URL(string: restaurantList[indexPath.row].externalLink) {
            let safariVC = SFSafariViewController(url: restaurantInfoURL)
            
            present(safariVC, animated: true)
        }
    }
    
}


// MARK: - UICollectionViewDataSource

extension MountainDetailVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.output.restaurantList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCVC.className,
                                                            for: indexPath) as? RestaurantCVC else {
            return UICollectionViewCell()
        }
        
        let restaurantList = viewModel.output.restaurantList.value
        cell.configureData(from: restaurantList[indexPath.row])
        
        return cell
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout

extension MountainDetailVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (screenWidth - 80.0) / 5
        let cellHeight = cellWidth + 20.0
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
