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
    }
    
    private let collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewLayout()
    )
    
    private let boxOfficeViewModel = BoxOfficeViewModel()
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
        collectionView.dataSource = self
        collectionView.register(KoreaBoxOfficeListCell.self
                                , forCellWithReuseIdentifier: KoreaBoxOfficeListCell.reuseIdentifier)
        collectionView.register(BoxOfficeHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: BoxOfficeHeaderView.reuseIdentifier)
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

//MARK: - Configure of DataSource
extension BoxOfficeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: BoxOfficeHeaderView.reuseIdentifier,
                for: indexPath) as? BoxOfficeHeaderView else {
                return UICollectionReusableView()
            }
            
            headerView.configureOfBoxOfficeLayout()
            return headerView
            
        default:
            print("해당되는 Header SectionType이 없습니다.")
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: KoreaBoxOfficeListCell.reuseIdentifier,
            for: indexPath) as? KoreaBoxOfficeListCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}
