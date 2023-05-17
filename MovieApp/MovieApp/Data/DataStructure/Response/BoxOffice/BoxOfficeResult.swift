//
//  BoxOfficeResult.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

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
