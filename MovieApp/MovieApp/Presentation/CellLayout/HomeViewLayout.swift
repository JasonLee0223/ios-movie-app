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
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(MagicNumber.RelatedToLayout.introduceCellItemFractionalWidthFraction),
                                              
                                              heightDimension: .fractionalHeight(MagicNumber.RelatedToLayout.fractionalDefaultFraction))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: MagicNumber.RelatedToLayout.itemInset,
                                                     leading: MagicNumber.RelatedToLayout.itemInset,
                                                     bottom: MagicNumber.RelatedToLayout.itemInset,
                                                     trailing: MagicNumber.RelatedToLayout.itemInset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(MagicNumber.RelatedToLayout.fractionalDefaultFraction),
                                               heightDimension: .fractionalHeight(MagicNumber.RelatedToLayout.fractionalDefaultFraction))
        let group = NSCollectionLayoutGroup(layoutSize: groupSize)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: MagicNumber.RelatedToLayout.itemInset,
                                                        leading: MagicNumber.RelatedToLayout.itemInset,
                                                        bottom: MagicNumber.RelatedToLayout.itemInset,
                                                        trailing: MagicNumber.RelatedToLayout.itemInset)
        
        return section
    }
    
    func createGenreCellCompositionalLayout() -> NSCollectionLayoutSection? {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(MagicNumber.RelatedToLayout.GenreCellItemFractionalWidthFraction),
                                              heightDimension: .fractionalHeight(MagicNumber.RelatedToLayout.fractionalDefaultFraction))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: MagicNumber.RelatedToLayout.itemInset,
                                                     leading: MagicNumber.RelatedToLayout.itemInset,
                                                     bottom: MagicNumber.RelatedToLayout.itemInset,
                                                     trailing: MagicNumber.RelatedToLayout.itemInset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(MagicNumber.RelatedToLayout.fractionalDefaultFraction),
                                               heightDimension: .fractionalHeight(MagicNumber.RelatedToLayout.fractionalDefaultFraction))
        let group = NSCollectionLayoutGroup(layoutSize: groupSize)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: MagicNumber.RelatedToLayout.itemInset,
                                                        leading: MagicNumber.RelatedToLayout.itemInset,
                                                        bottom: MagicNumber.RelatedToLayout.itemInset,
                                                        trailing: MagicNumber.RelatedToLayout.itemInset)
        return section
    }
}
