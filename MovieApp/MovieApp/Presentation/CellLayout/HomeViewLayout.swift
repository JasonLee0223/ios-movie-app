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
            widthDimension: .estimated(191),
            heightDimension: .estimated(64)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 2.3),
            heightDimension: .fractionalHeight(1.0 / 2.6)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.contentInsets = .init(top: 0, leading: 20, bottom: 40, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
    
    func createGenreCellCompositionalLayout() -> NSCollectionLayoutSection? {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .estimated(127),
            heightDimension: .estimated(56)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension:.fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 3.0),
            heightDimension: .fractionalHeight(1.0 / 5.5)
//            heightDimension: .fractionalHeight(1.0 / 1.5)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.contentInsets = .init(top: 0, leading: 10, bottom: 24, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: MagicNumber.RelatedToLayout.itemInset,
            leading: MagicNumber.RelatedToLayout.itemInset,
            bottom: MagicNumber.RelatedToLayout.itemInset,
            trailing: MagicNumber.RelatedToLayout.itemInset
        )
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
}
