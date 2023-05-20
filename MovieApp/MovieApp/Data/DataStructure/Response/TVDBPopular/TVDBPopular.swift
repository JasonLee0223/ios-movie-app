//
//  TVDBPopular.swift
//  MovieApp
//
//  Created by Jason on 2023/05/20.
//

import Foundation

// MARK: - TVDBPopular

struct TVDBPopular {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int
}

// MARK: - Result

internal struct Result {
    let movieID: Int
    let movieKoreaTitle: String
    let movieOriginTitle: String
    let overview: String
    let movieImageURL: String
    let releaseDate: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case movieID = "id"
        case movieKoreaTitle = "title"
        case movieOriginTitle = "originalTitle"
        case overview
        case movieImageURL = "posterPath"
        case releaseDate
        case voteAverage
    }
}
