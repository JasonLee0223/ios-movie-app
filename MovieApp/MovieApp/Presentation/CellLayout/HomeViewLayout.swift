//
//  HomeViewLayout.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

enum CellList: Int, CaseIterable {
    case IntroducePosterSection = 0
    case stillCutSection
    case koreaMovieListSection
}

struct HomeViewLayout {
    
    private let sectionIndex: Int
    
    init(sectionIndex: Int) {
        self.sectionIndex = sectionIndex
    }
    
    func create() -> NSCollectionLayoutSection? {
        let index = CellList.allCases[sectionIndex]
        switch index {
        case .IntroducePosterSection:
            return createIntroduceCellCompositionalLayout()
        case .stillCutSection:
            return createstillCutCellCompositionalLayout()
        case .koreaMovieListSection:
            return createKoreaMovieListCellCompositionalLayout()
        }
    }
    
    private func createIntroduceCellCompositionalLayout() -> NSCollectionLayoutSection? {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.1)
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
        item.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        
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
            top: MagicNumber.zero,
            leading: MagicNumber.RelatedToCompositionalLayout.ContentInset.introduceLeading,
            bottom: MagicNumber.zero,
            trailing: MagicNumber.zero
        )
        
        let section = NSCollectionLayoutSection(group: group ?? NSCollectionLayoutGroup(layoutSize: groupSize))
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 0, leading: 0, bottom: 230, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
    
    private func createstillCutCellCompositionalLayout() -> NSCollectionLayoutSection? {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.1)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension:.fractionalWidth(MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction),
            heightDimension: .fractionalHeight(MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 3.0),
            heightDimension: .fractionalWidth(0.35)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.contentInsets = .init(
            top: MagicNumber.zero,
            leading: MagicNumber.RelatedToCompositionalLayout.ContentInset.genreLeadingOrTrailing,
            bottom: MagicNumber.RelatedToCompositionalLayout.ContentInset.genreBottom,
            trailing: MagicNumber.RelatedToCompositionalLayout.ContentInset.genreLeadingOrTrailing
         )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
    
    private func createKoreaMovieListCellCompositionalLayout() -> NSCollectionLayoutSection? {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.1)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.2)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 0, bottom: 5, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
}
