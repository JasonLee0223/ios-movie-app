//
//  TMDBBasic.swift
//  MovieApp
//
//  Created by Jason on 2023/05/20.
//

import Foundation

enum TMDBBasic {
    static let trendMovieListBaseURL: String = "https://api.themoviedb.org/3/trending/movie/"
    static let movieDetailBaseURL: String =  "https://api.themoviedb.org/3/movie/"
    
    static let pathQueryOfWeak: String = "week"
    static let pathQueryOfDay: String = "day"
    static let pathQueryOfCredit: String = "credits"
    
    static let imageURL: String = "https://image.tmdb.org/t/p/original"
}
