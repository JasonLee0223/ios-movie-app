//
//  TMDBTrendMovieList.swift
//  MovieApp
//
//  Created by Jason on 2023/05/20.
//

import Foundation

// MARK: - TVDBPopular

struct TMDBTrendMovieList: Decodable {
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
    let movieImageURL: String

    enum CodingKeys: String, CodingKey {
        case movieID = "id"
        case movieKoreaTitle = "title"
        case movieImageURL = "poster_path"
    }
}
