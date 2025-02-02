//
//  MovieInformation.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

struct MovieInformation: BusinessModel {
    var identifier: UUID
    
    let posterHeaderArea: PosterHeaderArea
    let nations: [String]
    let genres: [String]
    let subInformation: SubInformation
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

internal struct PosterHeaderArea: Hashable {
    let watchGrade: String
    let movieKoreanName: String
    let movieEnglishName: String
}

internal struct SubInformation: Hashable {
    let releaseDate: String
    let runtime: String
    let overview: String
}
