//
//  Genre.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct Genre: Decodable {
    let genreName: String
    
    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}
