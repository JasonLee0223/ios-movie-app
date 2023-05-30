//
//  MovieInformation.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

struct MovieInformation {
    var identifier: UUID
    
    let movieSummary: MovieSummary
    let nations: [String]
    let genres: [String]
    let subInformation: SubInformation
}

internal struct MovieSummary {
    let watchGrade: String
    let movieKoreanName: String
    let movieEnglishName: String
}

internal struct SubInformation {
    let releaseDate: String
    let runtime: String
    let overview: String
}
