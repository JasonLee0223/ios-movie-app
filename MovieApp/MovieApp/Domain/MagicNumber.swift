//
//  MagicNumber.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

enum MagicNumber {
    static let zero: CGFloat = 0
    
    enum Attributes {
        static let genreTitleFont: CGFloat = 18
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
    
    enum RelatedToLayout {
        static let introduceCellItemFractionalWidthFraction: CGFloat = 1.0 / 10.0
        static let GenreCellItemFractionalWidthFraction: CGFloat = 1.0 / 13.0
        static let fractionalDefaultFraction: CGFloat = 1.0
        static let itemInset: CGFloat = 0
    }
}
