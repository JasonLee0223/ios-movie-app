//
//  KoreaBoxOfficeList.swift
//  MovieApp
//
//  Created by Jason on 2023/05/19.
//

import Foundation

struct KoreaBoxOfficeList: Hashable, BusinessModel {
    let identifier = UUID()
    let openDate: String
    let rank: Rank
    let movieSummaryInformation: MovieSummaryInformation
}

internal struct Rank: Hashable, BusinessModel {
    let rank: String
    let rankOldAndNew: RankOldAndNew
    let rankVariation: String
}

internal struct MovieSummaryInformation: Hashable, BusinessModel {
    let movieName: String
    let audienceCount: String
    let audienceAccumulated: String
}
