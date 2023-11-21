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
        
        self.headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(MagicNumber.HeaderView.fractionalWidth),
                                                heightDimension: .fractionalWidth(MagicNumber.HeaderView.fractionalHeight))
        
        self.header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .topLeading)
    }
    
    //MARK: - [Public Method] Configure of Layout
    func create() -> NSCollectionLayoutSection? {
        let index = HomeSection.allCases[sectionIndex]
        switch index {
        case .trendMoviePoster:
            return createTrendMoiveCellCompositionalLayout()
        case .stillCut:
            return createStillCutCellCompositionalLayout()
        case .koreaMovieList:
            return createKoreaMovieListCellCompositionalLayout()
        }
    }
    
    //MARK: - Private Property
    private let sectionIndex: Int
    private let headerSize: NSCollectionLayoutSize
    private let header: NSCollectionLayoutBoundarySupplementaryItem
}

//MARK: - [Private Method] Configure of HomeSection Layout
extension HomeViewLayout {
    
    /// First Section Layout
    private func createTrendMoiveCellCompositionalLayout() -> NSCollectionLayoutSection? {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction),
                                              heightDimension: .fractionalHeight(MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: MagicNumber.zero, leading: MagicNumber.zero,
                                   bottom: MagicNumber.RelatedToCompositionalLayout.ContentInset.introduceWidthConstraint, trailing: MagicNumber.zero)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(MagicNumber.RelatedToCompositionalLayout.GroupSize.introduceWidth),
                                               heightDimension: .fractionalHeight(MagicNumber.RelatedToCompositionalLayout.GroupSize.introduceHeight))
        
        let group: NSCollectionLayoutGroup?
        if #available(iOS 16.0, *) {
            group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     repeatingSubitem: item,
                                                     count: 2)
        } else {
            group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: 2)
        }
        
        group?.contentInsets = .init(top: 20, leading: MagicNumber.RelatedToCompositionalLayout.ContentInset.introduceLeading,
                                     bottom: MagicNumber.zero, trailing: MagicNumber.zero)
        
        let section = NSCollectionLayoutSection(group: group ?? NSCollectionLayoutGroup(layoutSize: groupSize))
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = .init(top: MagicNumber.zero, leading: MagicNumber.zero,
                                      bottom: MagicNumber.zero, trailing: MagicNumber.zero)
        return section
    }
    
    /// Second Section Layout
    private func createStillCutCellCompositionalLayout() -> NSCollectionLayoutSection? {
        
        let itemSize = NSCollectionLayoutSize(widthDimension:.fractionalWidth(MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction),
                                              heightDimension: .fractionalHeight(MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(MagicNumber.RelatedToCompositionalLayout.GroupSize.stillCutWidth),
                                               heightDimension: .fractionalWidth(MagicNumber.RelatedToCompositionalLayout.GroupSize.stillCutHeight))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: MagicNumber.zero, leading: MagicNumber.RelatedToCompositionalLayout.ContentInset.stillCutLeadingOrTrailing,
                                    bottom: MagicNumber.RelatedToCompositionalLayout.ContentInset.stillCutBottom,
                                    trailing: MagicNumber.RelatedToCompositionalLayout.ContentInset.stillCutLeadingOrTrailing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
    
    /// Third Section Layout
    private func createKoreaMovieListCellCompositionalLayout() -> NSCollectionLayoutSection? {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction),
                                              heightDimension: .fractionalWidth(MagicNumber.RelatedToCompositionalLayout.ItemSize.koreaMovieListHeight))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: MagicNumber.RelatedToCompositionalLayout.ContentInset.koreaMovieListTopOrBottom, leading: MagicNumber.zero,
                                   bottom: MagicNumber.RelatedToCompositionalLayout.ContentInset.koreaMovieListTopOrBottom, trailing: MagicNumber.zero)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction),
                                               heightDimension: .fractionalHeight(MagicNumber.RelatedToCompositionalLayout.fractionalDefaultFraction))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}
