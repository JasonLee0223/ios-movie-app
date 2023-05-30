//
//  TMDBMovieDetail.swift
//  MovieApp
//
//  Created by Jason on 2023/05/28.
//

import Foundation

struct TMDBMovieDetail: Decodable {
    let adult: Bool
    let genres: [Genre]
    let movieIdentifier: Int
    let movieEnglishTitle: String
    let overview: String
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let runtime: Int
    let summary: String
    let koreanTitle: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case adult
        case genres
        case movieIdentifier = "id"
        case movieEnglishTitle = "original_title"
        case overview
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case runtime
        case summary = "tagline"
        case koreanTitle = "title"
        case voteAverage = "vote_average"
    }
    
    // MARK: - Genre
    internal struct Genre: Decodable {
        let id: Int
        let name: String
    }

    // MARK: - ProductionCountry
    internal struct ProductionCountry: Decodable {
        let iso_3166_1: String
        let name: String
    }
}
