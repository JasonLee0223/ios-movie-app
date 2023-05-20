//
//  BoxOfficeQueryParameters.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct BoxOfficeQueryParameters: Encodable {
    let key = KOFICAPIMagicLiteral.key
    var targetDate: String
    
    enum CodingKeys: String, CodingKey {
        case key = "key"
        case targetDate = "targetDt"
    }
}
