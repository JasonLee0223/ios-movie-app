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
        static let weekTrendList = "이번 주 영화 트렌드"
        static let todayTrendList = "오늘 영화 트렌드"
        static let stillCut = "영화 스틸 컷"
        static let koreaBoxOfficeMovieList = "한국 박스오피스 영화 순위"
        
        static let movieOfficials = "감독 및 등장인물"
        static let audienceCount = "관람객 수"
    }
}
