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
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .black.withAlphaComponent(0.45)
            backgroundView.layer.cornerRadius = 10
            backgroundView.layer.masksToBounds = true
            
            $0.backgroundView = backgroundView
            $0.showsVerticalScrollIndicator = false
            
            $0.contentInset = UIEdgeInsets(top: Const.contentVerticalInset,
                                           left: 0,
                                           bottom: Const.contentVerticalInset,
                                           right: 0)
            $0.showsHorizontalScrollIndicator = false
            $0.register(BadgeCVC.self, forCellWithReuseIdentifier: BadgeCVC.className)
            $0.register(BadgeHeaderView.self,
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: BadgeHeaderView.className)
        }
    
    
    // MARK: - Variables and Properties
    
    private let viewModel: BadgeListVM = BadgeListVM()
    
    private enum Const {
        static let contentHorizontalInset: CGFloat = 13.0
        static let contentVerticalInset: CGFloat = 20.0
        static let collectionViewHorizontalInset: CGFloat = 16.0
    }
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.requestGetBadgeList()
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
        
        bindBadgeDataSource()
        bindCollectionView()
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
            $0.leading.trailing.equalToSuperview().inset(Const.collectionViewHorizontalInset)
            $0.bottom.equalToSuperview().offset(-12.0)
        }
        configureCollectionViewLayout()
    }
    
    private func configureCollectionViewLayout() {
        let collectionViewWidth: CGFloat = screenWidth - (Const.collectionViewHorizontalInset + Const.contentHorizontalInset + 20) * 2
        let interval: CGFloat = 10
        let cellWidth: CGFloat = (collectionViewWidth - interval * 2) / 3
        
        let columnLayout = CenterAlignedCollectionViewFlowLayout(
                itemSize: CGSize(width: cellWidth, height: cellWidth * 1.3),
                minimumInteritemSpacing: interval,
                minimumLineSpacing: 16.0,
                sectionInset: UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
            )
        columnLayout.headerReferenceSize = CGSize(width: collectionViewWidth, height: 20.0)
        
        badgeCollectionView.collectionViewLayout = columnLayout
    }
    
}


// MARK: - Bind

extension BadgeListVC {
    
    private func bindBadgeDataSource() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<BadgeListDataSource>( configureCell: {
            _,
            collectionView,
            indexPath,
            badge in
            
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: BadgeCVC.className,
                                     for: indexPath) as? BadgeCVC else {
                fatalError("Cannot deqeue cells named DetailCategoryChipCVC")
            }
            
            cell.configureCell(with: badge)

            return cell
        }, configureSupplementaryView: {
            dataSource,
            collectionView,
            title,
            indexPath in
            
            guard let header = collectionView
                .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                  withReuseIdentifier: BadgeHeaderView.className,
                                                  for: indexPath) as? BadgeHeaderView else {
                fatalError("Cannot deqeue SupplementaryView named CategoryDetailHeaderView")
            }
            header.setHeader(title: dataSource[indexPath.section].header)
            
            return header
          })

        viewModel.output.badgeListDataSource
            .bind(to: badgeCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
    private func bindCollectionView() {
        badgeCollectionView.rx.modelSelected(Badge.self)
            .withUnretained(self)
            .bind(onNext: { owner, badge in
                if badge.isAcquired {
                    let badgeBottomSheetVC = BadgeBottomSheetVC()
                    badgeBottomSheetVC.configureBottomSheet(by: badge)
                    
                    badgeBottomSheetVC.modalPresentationStyle = .overFullScreen
                    owner.present(badgeBottomSheetVC, animated: false)
                } else {
                    owner.showToast(message: "아직 획득하지 못했어요!")
                }
            })
            .disposed(by: bag)
    }
    
}

