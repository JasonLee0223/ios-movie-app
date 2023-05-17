//
//  Director.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct Director: Decodable {
    let peopleName: String
    let peopleNameInEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameInEnglish = "peopleNmEn"
    }
}
