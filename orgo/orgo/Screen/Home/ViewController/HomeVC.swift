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
    
    var mapView: MTMapView = MTMapView()
    
    
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
    
    // MARK: - Functions
    
}


// MARK: - Configure

extension HomeVC {
    
    private func configureInnerView() {
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

// MARK: - MTMapViewDelegate

extension HomeVC: MTMapViewDelegate {
    
}
