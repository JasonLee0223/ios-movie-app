//
//  CellList.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

struct Section: Hashable {
    var type: SectionList
    var items: [BusinessModelWrapper]
}

enum SectionList: Int, CaseIterable {
    case trendMoviePosterSection = 0
    case stillCutSection
    case koreaMovieListSection
}
