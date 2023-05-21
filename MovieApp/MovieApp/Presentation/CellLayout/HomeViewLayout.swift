//
//  HomeViewLayout.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

enum CellList: Int, CaseIterable {
    case IntroducePosterSection = 0
    case GenrePosterSection
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
        case .GenrePosterSection:
            return createGenreCellCompositionalLayout()
        }
    }
    
    func createIntroduceCellCompositionalLayout() -> NSCollectionLayoutSection? {
        
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
            widthDimension: .fractionalWidth(MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction),
            heightDimension: .fractionalHeight(MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
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
            bottom: MagicNumber.RelatedToCompositionalLayout.ContentInset.introduceBottom,
            trailing: MagicNumber.zero
        )
        
        let section = NSCollectionLayoutSection(group: group ?? NSCollectionLayoutGroup(layoutSize: groupSize))
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 0, leading: 0, bottom: 130, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
    
    func createGenreCellCompositionalLayout() -> NSCollectionLayoutSection? {
        
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
            widthDimension: .fractionalWidth(MagicNumber.RelatedToCompositionalLayout.GroupSize.genreWidth),
            heightDimension: .fractionalHeight(MagicNumber.RelatedToCompositionalLayout.GroupSize.genreHeight)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
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
}
