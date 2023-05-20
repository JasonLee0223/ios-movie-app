//
//  DailyBoxOfficeList.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct DailyBoxOfficeList: Decodable {
    let rank: String
    let rankOldAndNew: RankOldAndNew
    let movieCode: String
    let movieName: String
    let openDate: String

    enum CodingKeys: String, CodingKey {
        case rank
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
    }
}

enum RankOldAndNew: String, Decodable {
    case new = "NEW"
    case old = "OLD"
}
