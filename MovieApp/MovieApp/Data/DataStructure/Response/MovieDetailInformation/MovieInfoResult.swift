//
//  MovieInfoResult.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct MovieInfoResult: Decodable {
    let movieInfo: MovieInfo
    let source: String
}
