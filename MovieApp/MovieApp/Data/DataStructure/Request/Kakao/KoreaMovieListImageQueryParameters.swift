//
//  KoreaMovieListImageQueryParameters.swift
//  MovieApp
//
//  Created by Jason on 2023/05/22.
//

import Foundation

struct KoreaMovieListImageQueryParameters: Encodable {
    let query: String
    
    enum CodingKeys: String, CodingKey {
        case query = "query"
    }
}
