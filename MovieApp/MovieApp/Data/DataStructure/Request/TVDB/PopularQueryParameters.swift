//
//  PopularQueryParameters.swift
//  MovieApp
//
//  Created by Jason on 2023/05/20.
//

import Foundation

struct PopularQueryParameters: Encodable {
    let key = TVDBAPIMagicLiteral.key
    let language = TVDBAPIMagicLiteral.language
}
