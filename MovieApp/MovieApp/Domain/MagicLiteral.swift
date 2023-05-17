//
//  MagicLiteral.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

enum MagicLiteral {
    
    static let zero = "0"
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

    enum RelatedToHeaderView {
        static let movieRealeseTitle = "영화 개봉순"
        static let ticketingTitle = "예매율순"
        static let genreTitle = "장르별 영화"
        static let sortOfTypeFont: CGFloat = 14
        static let genreTitleFont: CGFloat = 18
        static let buttonSpcing: CGFloat = 12
    }
    
    enum RelatedToMovieIntroduceCell {
        static let posterTitleFont: CGFloat = 14
        static let spcing: CGFloat = 12
        static let posterImageCornerRadius: CGFloat = 10
    }
}
