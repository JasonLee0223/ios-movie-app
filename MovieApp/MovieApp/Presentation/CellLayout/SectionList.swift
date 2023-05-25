//
//  CellList.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

enum SectionList: Int, CaseIterable {
    case trendMoviePosterSection = 0
    case stillCutSection
    case koreaMovieListSection
    
    var index: Int {
        switch self {
        case .trendMoviePosterSection:
            return 0
        case .stillCutSection:
            return 1
        case .koreaMovieListSection:
            return 2
        }
    }
}
