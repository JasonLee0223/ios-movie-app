//
//  BoxOffice.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct BoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
    
    struct BoxOfficeResult: Decodable {
        let boxofficeType: String
        let dateRange: String
        let dailyBoxOfficeList: [DailyBoxOfficeList]

        enum CodingKeys: String, CodingKey {
            case boxofficeType
            case dailyBoxOfficeList
            case dateRange = "showRange"
        }
    }
}

struct DailyBoxOfficeList: Decodable {
    let rank: String
    let rankOldAndNew: RankOldAndNew
    let rankVariation: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let audienceCount: String
    let audienceAccumulate: String
    
    enum CodingKeys: String, CodingKey {
        case rank
        case rankOldAndNew
        case rankVariation = "rankInten"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case audienceCount = "audiCnt"
        case audienceAccumulate = "audiAcc"
    }
}

enum RankOldAndNew: String, Decodable {
    case new = "NEW"
    case old = "OLD"
}
