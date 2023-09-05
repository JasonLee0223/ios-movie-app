//
//  Gettable.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

protocol Gettable {
    var getLangauge: String { get }
    func getAPIKEY(type: APIKEYType) -> String
    func getCurrentDate() -> String
}

extension Gettable {
    
    var getLangauge: String {
        return "ko-KR"
    }
    
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
