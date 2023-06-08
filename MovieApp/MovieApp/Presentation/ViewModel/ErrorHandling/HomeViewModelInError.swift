//
//  ViewModelInError.swift
//  MovieApp
//
//  Created by Jason on 2023/05/26.
//

import Foundation

enum HomeViewModelInError: LocalizedError {
    case failOfMakeURL
    case failOfMakeData
    case failOfOptionalUnwrapping
    
    var errorDescription: String? {
        switch self {
        case .failOfMakeURL: return "❌ Fail Of Make URL"
        case .failOfMakeData: return "❌ Fail Of Make Data"
        case .failOfOptionalUnwrapping: return "❌ Fail Of bindModels Unwrapping"
        }
    }
}
