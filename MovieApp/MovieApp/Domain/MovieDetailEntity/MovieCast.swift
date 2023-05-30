//
//  MovieCast.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

struct MovieCast {
    let castInformation: CastInformation
    let job: String?
}

internal struct CastInformation {
    let originalName: String
    let profilePPath: String?
    let character: String?
}
