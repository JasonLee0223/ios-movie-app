//
//  MovieDetailQueryParameters.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct MovieDetailQueryParameters: Encodable {
    let key = KOFICAPIMagicLiteral.key
    var movieCode: String
    
    enum CodingKeys: String, CodingKey {
        case key = "key"
        case movieCode = "movieCd"
    }
}
