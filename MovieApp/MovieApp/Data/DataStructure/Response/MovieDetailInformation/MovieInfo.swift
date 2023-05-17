//
//  MovieInfo.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct MovieInfo: Decodable {
    let movieCode: String
    let movieName: String
    let movieNameInEnglish: String
    let movieNameOriginal: String
    let showTime: String
    let productionYear: String
    let openDate: String
    let productionStatusName: String
    let typeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staff]
    
    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieNameInEnglish = "movieNmEn"
        case movieNameOriginal = "movieNmOg"
        case showTime = "showTm"
        case productionYear = "prdtYear"
        case openDate = "openDt"
        case productionStatusName = "prdtStatNm"
        case typeName = "typeNm"
        case nations
        case genres
        case directors
        case actors
        case showTypes
        case companys
        case audits
        case staffs
    }
}
