//
//  KoreaBoxOfficeList.swift
//  MovieApp
//
//  Created by Jason on 2023/05/19.
//

import Foundation

struct KoreaBoxOfficeList: Hashable {
    let identifier = UUID()
    let openDate: String
    let rank: Rank
    let movieSummaryInformation: MovieSummaryInformation
}

internal struct Rank: Hashable {
    let rank: String
    let rankOldAndNew: RankOldAndNew
    let rankVariation: String
}

internal struct MovieSummaryInformation: Hashable {
    let movieName: String
    let audienceCount: String
    let audienceAccumulated: String
}
