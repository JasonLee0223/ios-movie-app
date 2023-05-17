//
//  Nation.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct Nation: Decodable {
    let nationName: String
    
    enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}
