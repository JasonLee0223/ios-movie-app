//
//  TMDBQueryParameters.swift
//  MovieApp
//
//  Created by Jason on 2023/05/20.
//

import Foundation

struct TMDBQueryParameters: Encodable {
    /// TMDBAPIMagicLiteral.language, TMDBAPIMagicLiteral.key
    let language: String
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case language = "language"
        case key = "api_key"
    }
}
