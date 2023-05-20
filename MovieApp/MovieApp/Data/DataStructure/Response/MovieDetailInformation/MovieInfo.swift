//
//  MovieInfo.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct MovieInfo: Decodable {
    let movieName: String
    let movieNameInEnglish: String
    let showTime: String
    let openDate: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let audits: [Audit]
    
    enum CodingKeys: String, CodingKey {
        case movieName = "movieNm"
        case movieNameInEnglish = "movieNmEn"
        case showTime = "showTm"
        case openDate = "openDt"
        case nations
        case genres
        case directors
        case actors
        case audits
    }
}
