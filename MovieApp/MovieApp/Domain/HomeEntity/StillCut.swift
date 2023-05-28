//
//  StillCut.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

struct StillCut: BusinessModel {
    var identifier: UUID
    
    let genreImagePath: Data
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
