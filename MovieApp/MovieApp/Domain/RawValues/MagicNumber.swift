//
//  MagicNumber.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

enum MagicNumber {
    static let zero: CGFloat = 0
    static let cornerRadius: CGFloat = 10
    
    enum HeaderView {
        static let sortStackTopAnchorConstraint: CGFloat = 24
        static let genreTitleTopAnchorConstraint: CGFloat = 28
        static let leadingConstraint: CGFloat = 20
    }
    
    enum Cell {
        static let bottomAnchorConstraint: CGFloat = -26
        static let multiplierOfLabel: CGFloat = 1/2
    }
    
    enum Attributes {
        static let navigationBarButtonFont: CGFloat = 25
        static let genreTitleFont: CGFloat = 23
        static let spcing: CGFloat = 12
        static let fontSize: CGFloat = 14
        static let imageCornerRadius: CGFloat = 10
    }
    
    enum Size {
        static let introducePosterWidth: CGFloat = 140
        static let introducePosterHeight: CGFloat = 198
        
        static let genrePosterWidth: CGFloat = 104
        static let genrePosterHeight: CGFloat = 104
    }
    
    enum RelatedToCompositionalLayout {
        static let fractionalDefaultFraction: CGFloat = 1.0
        
        enum GroupSize {
            static let introduceWidth: CGFloat = 1.0 / 2.3
            static let introduceHeight: CGFloat = 1.0 / 2.6
            
            static let genreWidth: CGFloat = 1.0 / 3.0
            static let genreHeight: CGFloat = 1.0 / 5.5
        }
        
        enum Header {
            static let introduceWidth: CGFloat = 191
            static let introduceHeight: CGFloat = 64
            
            static let genreWidth: CGFloat = 127
            static let genreHeight: CGFloat = 56
        }
        
        enum ContentInset {
            static let introduceLeading: CGFloat = 20
            static let introduceBottom: CGFloat = 40
            
            static let genreLeadingOrTrailing: CGFloat = 10
            static let genreBottom: CGFloat = 24
        }
    }
    
    enum RelatedToDataSource {
        static let numberOfPosterCount: Int = 10
        static let numberOfGenreCount: Int = 13
    }
}
