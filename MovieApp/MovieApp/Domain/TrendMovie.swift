//
//  TrendMovie.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

protocol BusinessModel: Hashable {
    var identifier: UUID { get }
}

struct TrendMovie: BusinessModel {
    var identifier: UUID
    
    let posterImage: Data
    let posterName: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
