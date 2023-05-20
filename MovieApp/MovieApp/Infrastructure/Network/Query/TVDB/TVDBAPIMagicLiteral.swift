//
//  TVDBAPIMagicLiteral.swift
//  MovieApp
//
//  Created by Jason on 2023/05/20.
//

import Foundation

enum TVDBAPIMagicLiteral {
    static let key = getOpenAPIKEY()
    static let language = "ko-KR"
    
    static func getOpenAPIKEY() -> String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "TVDBAPIKEY") as? String else {
            return ""
        }
        return apiKey
    }
}
