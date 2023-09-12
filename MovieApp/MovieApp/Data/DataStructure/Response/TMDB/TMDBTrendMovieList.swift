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
    let trendMovieItems: [MovieItem]
    let totalPages: Int
    let totalResults: Int
    
    // MARK: - Result

    struct MovieItem: Decodable {
        let movieID: Int
        let movieKoreaTitle: String
        let movieImageURL: String

        enum CodingKeys: String, CodingKey {
            case movieID = "id"
            case movieKoreaTitle = "title"
            case movieImageURL = "poster_path"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case trendMovieItems = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
