//
//  HomeVC.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import Foundation

import RxSwift
import RxCocoa
import RxGesture

import Then
import SnapKit

class HomeVC: BaseViewController {
    
    // MARK: - UI components
    
    let searchView: SearchView = SearchView()
    
    
    // MARK: - Variables and Properties
    
    private let viewModel: HomeVM = HomeVM()
    
    var mapView: MTMapView = MTMapView()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestGetMountainList()
    }
    
    override func configureView() {
        super.configureView()
        
        configureInnerView()
        configureMap()
    }
    
    override func layoutView() {
        super.layoutView()
        
        configureLayout()
    }
    
    override func bindInput() {
        super.bindInput()
        
        bindSearchView()
    }
    
    override func bindOutput() {
        super.bindOutput()
        
        bindMountainList()
    }
    
    // MARK: - Functions
    
    func showBottomSheet(mountainInfo: MountainListResponseModel) {
        let bottomSheetVC = MountainBottomSheetVC()
        bottomSheetVC.configureInfo(from: mountainInfo)
        
        let bottomSheetWithNavigation = BaseNavigationController(rootViewController: bottomSheetVC)
        
        bottomSheetWithNavigation.modalPresentationStyle = .overFullScreen
        present(bottomSheetWithNavigation, animated: false)
    }
}


// MARK: - Configure

extension HomeVC {
    
    private func configureInnerView() {
        view.addSubviews([mapView])
    }
    
    private func configureMap() {
        mapView.delegate = self
        mapView.baseMapType = .standard
        
        mapView.addSubviews([searchView])
    }
    
}


// MARK: - Layout

extension HomeVC {
    
    private func configureLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(60.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(44.0)
        }
    }
    
}


// MARK: - Output

extension HomeVC {
    
    private func bindMountainList() {
        viewModel.output.mountainList
            .filter({ !$0.isEmpty })
            .withUnretained(self)
            .subscribe { owner, mountainList in
                for (id, mountainInfo) in mountainList.enumerated() {
                    owner.createMarker(id: id, location: mountainInfo.location)
                }
            }
            .disposed(by: bag)
    }
    
    private func bindSearchView() {
        searchView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let searchVC = SearchVC()
                
                owner.navigationController?.pushViewController(searchVC, animated: true)
            })
            .disposed(by: bag)
    }
    
}


// MARK: - MTMapViewDelegate

extension HomeVC: MTMapViewDelegate {
    
    /// 마커 선택되었을 때
    func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
        showBottomSheet(mountainInfo: viewModel.output.mountainList.value[poiItem.tag])
        
        return false
    }
    
    // 줌 레벨이 변경될 때 호출되는 delegate 메서드
    func mapView(_ mapView: MTMapView!, zoomLevelChangedTo zoomLevel: MTMapZoomLevel) {

    }
    
}


// MARK: - 마커

extension HomeVC {
    
    private func createMarker(id: Int, location: Location) {
        let markerPoiItem = MTMapPOIItem()
        markerPoiItem.markerType = .customImage
        markerPoiItem.mapPoint = .init(geoCoord: .init(latitude: location.latitude, longitude: location.longitude))
        markerPoiItem.customImageName = "MountainMarker"
        markerPoiItem.tag = id
        
        mapView.addPOIItems([markerPoiItem])
    }
    
}
