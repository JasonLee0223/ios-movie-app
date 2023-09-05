//
//  APIKEYType.swift
//  MovieApp
//
//  Created by Jason on 2023/09/05.
//

import Foundation

enum APIKEYType {
    case TMDB
    case KOFIC
    
    var keyName: String {
        switch self {
        case .TMDB: return "TVDBAPIKEY"
        case .KOFIC: return "BoxOfficeAPIKEY"
        }
    }
    
    var keyValue: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: self.keyName) as? String else { return "" }
        return apiKey
    }
}
