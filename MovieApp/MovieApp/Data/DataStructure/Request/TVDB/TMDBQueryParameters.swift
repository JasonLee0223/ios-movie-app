//
//  TMDBQueryParameters.swift
//  MovieApp
//
//  Created by Jason on 2023/05/20.
//

import Foundation

struct TMDBQueryParameters: Encodable {
    let language = TVDBAPIMagicLiteral.language
    let key = TVDBAPIMagicLiteral.key
    
    enum CodingKeys: String, CodingKey {
        case language = "language"
        case key = "api_key"
    }
}
