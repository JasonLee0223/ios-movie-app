//
//  TMDBMovieCredit.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

// MARK: - Welcome2
struct TMDBMovieCredit {
    let id: Int
    let cast: [Cast]
    let crew: [Cast]
}

// MARK: - Cast
/// department의 directing을 찾아서 Job을 director 찾기
struct Cast {
    let originalName: String
    let profilePath: String?
    let character: String?
    let department: Department?
    let job: String?
}

enum Department {
    case acting
    case art
    case camera
    case costumeMakeUp
    case crew
    case directing
    case editing
    case production
    case sound
    case visualEffects
    case writing
}
