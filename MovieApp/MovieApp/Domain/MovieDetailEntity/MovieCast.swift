//
//  MovieCast.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

struct MovieCast: BusinessModel {
    let identifier: UUID
    let castInformation: CastInformation
    let peopleImage: Data
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

internal struct CastInformation: Hashable {
    let originalName: String
    let character: String?
    let job: String?
}
