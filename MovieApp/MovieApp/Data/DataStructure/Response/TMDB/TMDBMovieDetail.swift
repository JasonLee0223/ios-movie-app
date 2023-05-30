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
        case movieEnglishTitle = "originalTitle"
        case overview
        case productionCountries
        case releaseDate
        case runtime
        case summary = "tagline"
        case koreanTitle = "title"
        case voteAverage
    }
    
    // MARK: - Genre
    internal struct Genre: Decodable {
        let id: Int
        let name: String
    }

    // MARK: - ProductionCountry
    internal struct ProductionCountry: Decodable {
        let iso3166_1, name: String
    }
}
