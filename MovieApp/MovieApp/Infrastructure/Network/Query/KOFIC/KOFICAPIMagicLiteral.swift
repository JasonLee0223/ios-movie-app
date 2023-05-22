//
//  APIMagicLiteral.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

enum KOFICAPIMagicLiteral {
    static let key = getAPIKEY()
    static let targetQuery = "targetDt"
    static let movieCode = "movieCd"
    
    private static func getAPIKEY() -> String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "BoxOfficeAPIKEY") as? String else {
            return ""
        }
        return apiKey
    }
}
