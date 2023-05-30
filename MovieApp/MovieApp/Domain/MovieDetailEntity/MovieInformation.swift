//
//  MovieInformation.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

struct MovieInformation: Hashable {
    var identifier: UUID
    
    let movieSummary: MovieSummary
    let nations: [String]
    let genres: [String]
    let subInformation: SubInformation
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

internal struct MovieSummary: Hashable {
    let watchGrade: String
    let movieKoreanName: String
    let movieEnglishName: String
}

internal struct SubInformation: Hashable {
    let releaseDate: String
    let runtime: String
    let overview: String
}
