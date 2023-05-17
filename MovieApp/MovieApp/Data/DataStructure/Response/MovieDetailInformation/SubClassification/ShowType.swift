//
//  ShowType.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct ShowType: Decodable {
    let showTypeGroupName: String
    let showTypeName: String
    
    enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}
