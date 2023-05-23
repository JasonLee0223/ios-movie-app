//
//  MagicNumber.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

enum MagicNumber {
    static let zero: CGFloat = 0
    static let borderWidth: CGFloat = 0.5
    static let cornerRadius: CGFloat = 10
    
    enum HeaderView {
        static let fractionalWidth: CGFloat = 1.0
        static let fractionalHeight: CGFloat = 0.1
    }
    
    enum Cell {
        static let bottomAnchorConstraint: CGFloat = -26
        static let multiplierOfLabel: CGFloat = 1/2
        static let widthAnchorMultiplier: CGFloat = 0.2
        static let leadingAnchorConstraint: CGFloat = 15
    }
    
    enum Attributes {
        static let navigationBarButtonFont: CGFloat = 25
        static let headerTitleFont: CGFloat = 23
        static let spcing: CGFloat = 12
        static let fontSize: CGFloat = 15
        static let imageCornerRadius: CGFloat = 10
    }
    
    enum Size {
        static let introducePosterWidth: CGFloat = 140
    }
    
    enum RelatedToCompositionalLayout {
        static let fractionalDefaultFraction: CGFloat = 1.0
        
        enum ItemSize {
            static let koreaMovieListHeight: CGFloat = 0.2
        }
        
        enum GroupSize {
            static let introduceWidth: CGFloat = 1.0 / 2.3
            static let introduceHeight: CGFloat = 1.0 / 2.0
            
            static let stillCutWidth: CGFloat = 1.0 / 3.0
            static let stillCutHeight: CGFloat = 0.35
        }
        
        enum ContentInset {
            static let sectionBottomConstraint: CGFloat = 230
            
            static let introduceLeading: CGFloat = 10
            static let introduceWidthConstraint: CGFloat = 20
            
            static let stillCutLeadingOrTrailing: CGFloat = 10
            static let stillCutBottom: CGFloat = 24
            
            static let koreaMovieListTopOrBottom: CGFloat = 5
        }
    }
    
    enum RelatedToDataSource {
        static let numberOfPosterCount: Int = 10
        static let numberOfGenreCount: Int = 13
    }
}
