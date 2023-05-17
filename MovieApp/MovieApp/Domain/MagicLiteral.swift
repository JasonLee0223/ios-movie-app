//
//  MagicLiteral.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

enum MagicLiteral {
    
    static let newMovie = "신작"
    static let upTriangle = "arrowtriangle.up.fill"
    static let downTriangle = "arrowtriangle.down.fill"
    static let dateFormat = "yyyy-MM-dd"
    static let todayAudience = "오늘 "
    static let totalAudience = " / 총 "
    
    enum RelatedToNavigationController {
        static let navigationTitle = "야곰 시네마 🐻‍❄️"
        static let hambergImageName = "Hamberger"
        static let ticketImageName = "Ticket"
        static let mapImageName = "map"
    }

    enum Title {
        static let movieRealese = "영화 개봉순"
        static let ticketing = "예매율순"
        static let genre = "장르별 영화"
    }
}

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
}
