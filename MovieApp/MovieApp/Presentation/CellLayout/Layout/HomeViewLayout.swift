//
//  HomeViewLayout.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

struct HomeViewLayout {
    
    //MARK: - Initializer
    
    init(sectionIndex: Int) {
        self.sectionIndex = sectionIndex
    }
    
    //MARK: - [Public Method] Configure of Layout
    func create() -> NSCollectionLayoutSection? {
        let index = HomeSection.allCases[sectionIndex]
        switch index {
        case .trendMoviePoster:
            return createIntroduceCellCompositionalLayout()
        }
    }
    
    //MARK: - Private Property
    private let sectionIndex: Int
}

//MARK: - [Private Method] Configure of HomeSection Layout
extension HomeViewLayout {
    
    private func createIntroduceCellCompositionalLayout() -> NSCollectionLayoutSection? {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(MagicNumber.HeaderView.fractionalWidth),
            heightDimension: .fractionalWidth(MagicNumber.HeaderView.fractionalHeight)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction),
            heightDimension: .fractionalHeight(MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(
            top: MagicNumber.zero,
            leading: MagicNumber.zero,
            bottom: MagicNumber.RelatedToCompositionalLayout.ContentInset.introduceWidthConstraint,
            trailing: MagicNumber.zero
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(MagicNumber.RelatedToCompositionalLayout.GroupSize.introduceWidth),
            heightDimension: .fractionalHeight(MagicNumber.RelatedToCompositionalLayout.GroupSize.introduceHeight)
        )
        
        let group: NSCollectionLayoutGroup?
        if #available(iOS 16.0, *) {
            group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                repeatingSubitem: item,
                count: 2
            )
        } else {
            group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitem: item,
                count: 2
            )
        }
        
        group?.contentInsets = .init(
            top: 20,
            leading: MagicNumber.RelatedToCompositionalLayout.ContentInset.introduceLeading,
            bottom: MagicNumber.zero,
            trailing: MagicNumber.zero
        )
        
        let section = NSCollectionLayoutSection(group: group ?? NSCollectionLayoutGroup(layoutSize: groupSize))
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = .init(
            top: MagicNumber.zero,
            leading: MagicNumber.zero,
            bottom: MagicNumber.RelatedToCompositionalLayout.ContentInset.sectionBottomConstraint,
            trailing: MagicNumber.zero
        )
        
        return section
    }
}
