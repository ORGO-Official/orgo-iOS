//
//  HomeVC.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import Foundation

import RxSwift
import RxCocoa

import Then
import SnapKit

class HomeVC: BaseViewController {
    
    // MARK: - UI components
    
    
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
        configureMarker()
    }
    
    override func layoutView() {
        super.layoutView()
        
        configureLayout()
    }
    
    override func bindOutput() {
        super.bindOutput()
        
        bindMountainList()
    }
    
    // MARK: - Functions
    
    func showBottomSheet() {
        let bottomSheetVC = OrgoBottomSheet()
        
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        present(bottomSheetVC, animated: false)
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
        
        view.addSubviews([mapView])
    }
    
}


// MARK: - Layout

extension HomeVC {
    
    private func configureLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
                print(mountainList[0])
                
            }
            .disposed(by: bag)
    }
    
}


// MARK: - MTMapViewDelegate

extension HomeVC: MTMapViewDelegate {
    
    /// 마커 선택되었을 때
    func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
        print(poiItem.tag)
        
        showBottomSheet()
        
        return false
    }
    
    // 줌 레벨이 변경될 때 호출되는 delegate 메서드
    func mapView(_ mapView: MTMapView!, zoomLevelChangedTo zoomLevel: MTMapZoomLevel) {

    }
    
}


// MARK: - 마커

extension HomeVC {
    
    private func configureMarker() {
        let lat: Double = 37.5666805
        let lon: Double = 126.9784147
        
        let testPoiItem = MTMapPOIItem()
        testPoiItem.markerType = .customImage
        testPoiItem.mapPoint = .init(geoCoord: .init(latitude: lat, longitude: lon))
        testPoiItem.customImageName = "OrgoLogoGreen"
        testPoiItem.tag = 1
        
        
        mapView.addPOIItems([testPoiItem])
    }
    
}
