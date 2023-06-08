//
//  TrendMovie.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

struct TrendMovie: BusinessModel {
    
    let movieCode: String
    let posterImage: Data
    let posterName: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
