//
//  Actor.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct Actor: Decodable {
    let peopleName: String
    let peopleNameInEnglish: String
    let cast: String
    let castInEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameInEnglish = "peopleNmEn"
        case cast
        case castInEnglish = "castEn"
    }
}
