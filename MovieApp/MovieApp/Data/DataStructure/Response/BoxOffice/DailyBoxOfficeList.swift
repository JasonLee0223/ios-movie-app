//
//  DailyBoxOfficeList.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct DailyBoxOfficeList: Decodable {
    let rankNum: String
    let rank: String
    let rankVariation: String
    let rankOldAndNew: RankOldAndNew
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesVariation: String
    let salesChange: String
    let salesAccumulate: String
    let audienceCount: String
    let audienceVariation: String
    let audienceChange: String
    let audienceAccumulate: String
    let screenCount: String
    let showCount: String

    enum CodingKeys: String, CodingKey {
        case rank
        case rankOldAndNew
        case salesShare
        case salesChange
        case rankVariation = "rankInten"
        case rankNum = "rnum"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesVariation = "salesInten"
        case salesAccumulate = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceVariation = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulate = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}

enum RankOldAndNew: String, Decodable {
    case new = "NEW"
    case old = "OLD"
}
