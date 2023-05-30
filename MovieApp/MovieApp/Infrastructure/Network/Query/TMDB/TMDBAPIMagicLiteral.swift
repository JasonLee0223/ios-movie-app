//
//  TMDBAPIMagicLiteral.swift
//  MovieApp
//
//  Created by Jason on 2023/05/20.
//

import Foundation

enum TMDBAPIMagicLiteral {
    static let key = getOpenAPIKEY()
    static let language = "ko-KR"
    
    private static func getOpenAPIKEY() -> String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "TVDBAPIKEY") as? String else {
            return ""
        }
        return apiKey
    }
}
