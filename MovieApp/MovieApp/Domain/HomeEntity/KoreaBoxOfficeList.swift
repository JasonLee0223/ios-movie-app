//
//  KoreaBoxOfficeList.swift
//  MovieApp
//
//  Created by Jason on 2023/05/19.
//

import Foundation

struct KoreaBoxOfficeList: BusinessModel {
    
    let openDate: String
    let rank: Rank
    let movieSummaryInformation: MovieSummaryInformation
}

internal struct Rank: BusinessModel {
    
    let rank: String
    let rankOldAndNew: RankOldAndNew
    let rankVariation: String
}

internal struct MovieSummaryInformation: BusinessModel {
    
    let movieName: String
    let audienceCount: String
    let audienceAccumulated: String
}
