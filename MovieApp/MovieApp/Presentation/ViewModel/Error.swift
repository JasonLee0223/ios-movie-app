//
//  Error.swift
//  MovieApp
//
//  Created by Jason on 2023/05/26.
//

import Foundation

enum ViewModelInError: LocalizedError {
    case failOfMakeURL
    case failOfMakeData
    
    var errorDescription: String? {
        switch self {
        case .failOfMakeURL: return "❌ Fail Of Make URL"
        case .failOfMakeData: return "❌ Fail Of Make Data"
        }
    }
}
