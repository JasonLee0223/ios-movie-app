//
//  BoxOfficeViewController.swift
//  MovieApp
//
//  Created by Jason on 2023/08/10.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOfUI()
        configureHierarchy()
        
        configureOfDiffableDataSource()
        boxOfficeSnapshot()
    }
    
    private let boxOfficeViewModel = BoxOfficeViewModel()
    
    private let collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewLayout()
    )
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<BoxOfficeSection, KoreaBoxOfficeList>?
    
    private var snapshot = NSDiffableDataSourceSnapshot<BoxOfficeSection, KoreaBoxOfficeList>()
}


//MARK: - Configure of View
extension BoxOfficeViewController {
    
    private func configureOfUI() {
        configureOfSuperView()
        configureOfCollectionView()
    }
    
    private func configureOfSuperView() {
        self.view.backgroundColor = .black
    }
    
    private func configureOfCollectionView() {
        collectionView.isScrollEnabled = true
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .black
        collectionView.collectionViewLayout = configureOfCollectionViewLayout()
        collectionView.register(
            KoreaBoxOfficeListCell.self, forCellWithReuseIdentifier: KoreaBoxOfficeListCell.reuseIdentifier
        )
        collectionView.register(
            BoxOfficeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: BoxOfficeHeaderView.reuseIdentifier
        )
    }
}

//MARK: - Configure of Layout
extension BoxOfficeViewController {
    
    private func configureHierarchy() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func configureOfCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(MagicNumber.HeaderView.fractionalWidth),
            heightDimension: .fractionalHeight(MagicNumber.HeaderView.fractionalHeight)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(
                MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction
            ),
            heightDimension: .fractionalWidth(
                MagicNumber.RelatedToCompositionalLayout.ItemSize.koreaMovieListHeight
            )
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(
            top: MagicNumber.RelatedToCompositionalLayout.ContentInset.koreaMovieListTopOrBottom,
            leading: MagicNumber.zero,
            bottom: MagicNumber.RelatedToCompositionalLayout.ContentInset.koreaMovieListTopOrBottom,
            trailing: MagicNumber.zero
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(
                MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction
            ),
            heightDimension: .fractionalHeight(
                MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction
            )
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

//MARK: - Configure of DiffableDataSource
extension BoxOfficeViewController {
    
    private func boxOfficeSnapshot() {
        
        BoxOfficeSection.allCases.forEach { section in
            
            Task {
//                let apiData = await boxOfficeViewModel.fetchBoxOfficeMovieList()
                
//                snapshot.appendSections([section])
//                snapshot.appendItems(apiData)
//                await diffableDataSource?.apply(snapshot, animatingDifferences: true)
            }
        }
    }
    
    private func configureOfDiffableDataSource() {
        let boxOfficeCellRegistration = UICollectionView.CellRegistration<KoreaBoxOfficeListCell, KoreaBoxOfficeList> {
            (cell, indexPath, boxOffice) in
            cell.configure(boxOffice, at: indexPath)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<BoxOfficeHeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { headerView, elementKind, indexPath in
            headerView.configureOfBoxOfficeLayout()
        }
        
        diffableDataSource = UICollectionViewDiffableDataSource<BoxOfficeSection, KoreaBoxOfficeList>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, itemOfBoxOffice) in
                collectionView.dequeueConfiguredReusableCell(
                    using: boxOfficeCellRegistration, for: indexPath, item: itemOfBoxOffice
                )
            }
        )
        
        diffableDataSource?.supplementaryViewProvider = { (view, kind, indexPath) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: indexPath
            )
        }
    }
}
