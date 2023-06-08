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
    case dataIsEmpty
    
    var errorDescription: String? {
        switch self {
        case .failOfMakeURL: return "❌ \(#function): Fail Of Make URL"
        case .failOfMakeData: return "❌ \(#function): Fail Of Make Data"
        case .failOfOptionalUnwrapping: return "❌ \(#function): Fail Of bindModels Unwrapping"
        case .dataIsEmpty: return "❌ \(#function): Data Is E.M.P.T.Y"
        }
    }
}
