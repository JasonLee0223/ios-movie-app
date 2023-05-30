//
//  TMDBMovieCredit.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

struct TMDBMovieCredit: Decodable {
    let cast: [Cast]
    let crew: [Cast]
}

/// department의 directing을 찾아서
struct Cast: Decodable {
    let name: String
    let profilePath: String?
    let department: String?
    let character: String?
    let job: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case profilePath = "profile_path"
        case department = "known_for_department"
        case character = "character"
        case job
    }
}
