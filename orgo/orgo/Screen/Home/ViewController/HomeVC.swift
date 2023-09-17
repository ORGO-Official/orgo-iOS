//
//  HomeVC.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import Foundation
import CoreLocation

import RxSwift
import RxCocoa
import RxGesture

import Then
import SnapKit

class HomeVC: BaseViewController {
    
    // MARK: - UI components
    
    let searchView: SearchView = SearchView()

    let locationBtn: FloatingButton = FloatingButton(image: ImageAssets.myLocation)
    
    
    // MARK: - Variables and Properties
    
    private let viewModel: HomeVM = HomeVM()
    private let locationManager: CLLocationManager = CLLocationManager()
    
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
        bindLocationBtn()
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
    
    func requestCurrentLocation() {
        let authorization = locationManager.authorizationStatus
        
        switch authorization {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
            moveToCurrentLocation()
        case .notDetermined, .restricted:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func moveToCurrentLocation() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            if CLLocationManager.locationServicesEnabled() {
                self.mapView.showCurrentLocationMarker = true
                self.mapView.currentLocationTrackingMode = .onWithoutHeading
            }
        }
    }
    
    func offTracking() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            if CLLocationManager.locationServicesEnabled() {
                self.mapView.showCurrentLocationMarker = false
                self.mapView.currentLocationTrackingMode = .off
            }
        }
    }
    
}


// MARK: - Configure

extension HomeVC {
    
    private func configureInnerView() {
        view.addSubviews([mapView, locationBtn])
    }
    
    private func configureMap() {
        mapView.delegate = self
        mapView.baseMapType = .standard
        
        mapView.addSubviews([searchView])
        
        locationManager.delegate = self
    }
    
}


// MARK: - Layout

extension HomeVC {
    
    private func configureLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(44.0)
        }
        
        locationBtn.snp.makeConstraints {
            $0.height.width.equalTo(50.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-150.0)
        }
    }
    
}

// MARK: - Input

extension HomeVC {
    
    private func bindLocationBtn() {
        locationBtn.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                if owner.mapView.currentLocationTrackingMode == .off {
                    owner.requestCurrentLocation()
                } else {
                    owner.offTracking()
                }
            })
            .disposed(by: bag)
    }
    
    private func bindSearchView() {
        searchView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let searchVC = SearchVC()
                searchVC.delegate = owner
                
                owner.navigationController?.pushViewController(searchVC, animated: true)
            })
            .disposed(by: bag)
    }
    
}

// MARK: - Output

extension HomeVC {
    
    private func bindMountainList() {
        viewModel.output.mountainList
            .filter({ !$0.isEmpty })
            .withUnretained(self)
            .subscribe { owner, mountainList in
                mountainList.forEach { mountainInfo in
                    owner.createMarker(by: mountainInfo)
                }
            }
            .disposed(by: bag)
    }
    
}


// MARK: - MTMapViewDelegate

extension HomeVC: MTMapViewDelegate {
    
    /// 마커 선택되었을 때
    func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
        let mountain = viewModel.output.mountainList.value[poiItem.tag]
        mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: mountain.location.latitude,
                                                                longitude: mountain.location.longitude)), animated: true)
        showBottomSheet(mountainInfo: mountain)
        
        return false
    }
    
    // 줌 레벨이 변경될 때 호출되는 delegate 메서드
    func mapView(_ mapView: MTMapView!, zoomLevelChangedTo zoomLevel: MTMapZoomLevel) {

    }
    
}


// MARK: - 마커

extension HomeVC {
    
    private func createMarker(by mountainInfo: MountainListResponseModel) {
        let markerPoiItem = MTMapPOIItem()
        markerPoiItem.markerType = .customImage
        markerPoiItem.mapPoint = .init(geoCoord: .init(latitude: mountainInfo.location.latitude,
                                                       longitude: mountainInfo.location.longitude))
        markerPoiItem.customImage = getMarkerImage(from: mountainInfo.location.altitude)
        markerPoiItem.tag = mountainInfo.id - 1
        
        mapView.addPOIItems([markerPoiItem])
    }
    
    private func getMarkerImage(from altitude: Double) -> UIImage? {
        if (200..<400) ~= altitude {
            return ImageAssets.mountain200Marker
        }
        
        if (400..<600) ~= altitude {
            return ImageAssets.mountain400Marker
        }
        
        if (600..<800) ~= altitude {
            return ImageAssets.mountain600Marker
        }
        
        return ImageAssets.mountain800Marker
    }
    
}

// MARK: - CLLocationManagerDelegate

extension HomeVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}


// MARK: - SearchResultDelegate

extension HomeVC: SearchResultDelegate {
    func selectMountain(_ data: MountainListResponseModel) {
        mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: data.location.latitude,
                                                                longitude: data.location.longitude)), animated: true)
        showBottomSheet(mountainInfo: data)
    }
}
