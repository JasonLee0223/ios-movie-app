//
//  MovieCast.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

struct MovieCast {
    let castInformation: CastInformation
    let department: Department?
    let job: String?
}

internal struct CastInformation {
    let originalName: String
    let profilePath: String?
    let character: String?
}
