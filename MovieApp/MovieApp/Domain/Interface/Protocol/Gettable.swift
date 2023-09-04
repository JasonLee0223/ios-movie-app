//
//  Gettable.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

protocol Gettable {
    func getAPIKEY(type: APIKEYType) -> String
    func getCurrentDate() -> String
}

extension Gettable {
    
    func getAPIKEY(type: APIKEYType) -> String {
        return type.keyValue
    }
    
    func getCurrentDate() -> String {
        
        guard let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return ""}

        let formatter = DateFormatter()
        formatter.dateFormat = MagicLiteral.dateFormat
        let currentDateString = formatter.string(from: date)

        return currentDateString
    }
}

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
