//
//  TMDBPopular.swift
//  MovieApp
//
//  Created by Jason on 2023/05/20.
//

import Foundation

// MARK: - TVDBPopular

struct TMDBPopular: Decodable {
    let page: Int
    let results: [Result]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result

internal struct Result: Decodable {
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
        case movieOriginTitle = "original_title"
        case overview
        case movieImageURL = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
