//
//  KoreaBoxOfficeList.swift
//  MovieApp
//
//  Created by Jason on 2023/05/19.
//

import Foundation

struct KoreaBoxOfficeList: BusinessModel {
    let identifier: UUID
    let openDate: String
    let rank: Rank
    let movieSummaryInformation: MovieSummaryInformation
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

internal struct Rank: BusinessModel {
    var identifier: UUID
    
    let rank: String
    let rankOldAndNew: RankOldAndNew
    let rankVariation: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

internal struct MovieSummaryInformation: BusinessModel {
    var identifier: UUID
    
    let movieName: String
    let audienceCount: String
    let audienceAccumulated: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
