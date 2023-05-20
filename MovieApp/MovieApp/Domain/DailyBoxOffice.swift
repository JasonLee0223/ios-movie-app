//
//  DailyBoxOffice.swift
//  MovieApp
//
//  Created by Jason on 2023/05/19.
//

import Foundation

struct DailyBoxOffice: Hashable {
    let identifier = UUID()
    let movieSummaryInformation: MovieSummaryInformation
    let rank: Rank
}

internal struct Rank: Hashable {
    let openDate: String
    let rank: String
    let rankOldAndNew: RankOldAndNew
}

internal struct MovieSummaryInformation: Hashable {
    let movieName: String
    let audienceAccumulated: String
}

