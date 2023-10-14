//
//  BadgeListVC.swift
//  orgo
//
//  Created by 김태현 on 2023/10/13.
//

import Foundation

import RxSwift
import RxCocoa
import RxGesture
import RxDataSources

import Then
import SnapKit

final class BadgeListVC: BaseViewController {
    
    // MARK: - UI components
    
    private let badgeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        .then {
            $0.backgroundColor = .clear
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            $0.collectionViewLayout = layout
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .black.withAlphaComponent(0.45)
            backgroundView.layer.cornerRadius = 30
            backgroundView.layer.masksToBounds = true
            
            $0.backgroundView = backgroundView
            $0.showsHorizontalScrollIndicator = false
            $0.register(BadgeCVC.self, forCellWithReuseIdentifier: BadgeCVC.className)
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
    
    // MARK: - Functions
    
}


// MARK: - Configure

extension BadgeListVC {
    
    private func configureInnerView() {
        view.backgroundColor = ColorAssets.mainGreen
        
        view.addSubview(badgeCollectionView)
    }
    
}


// MARK: - Layout

extension BadgeListVC {
    
    private func configureLayout() {
        badgeCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview()
        }
    }
    
}
