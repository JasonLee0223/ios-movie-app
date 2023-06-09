//
//  ViewModelInError.swift
//  MovieApp
//
//  Created by Jason on 2023/05/26.
//

import Foundation

enum HomeViewModelInError: LocalizedError {
    case failOfLoadToTrendMovieList
    case failOfMakeURL
    case failOfMakeData
    case failOfOptionalUnwrapping
    case dataIsEmpty
    case failOfImageConverting
    
    var errorDescription: String? {
        switch self {
        case .failOfLoadToTrendMovieList: return "❌ \(#function): Fail of load to trendMovieList"
        case .failOfMakeURL: return "❌ \(#function): Fail Of Make URL"
        case .failOfMakeData: return "❌ \(#function): Fail Of Make Data"
        case .failOfOptionalUnwrapping: return "❌ \(#function): Fail Of bindModels Unwrapping"
        case .dataIsEmpty: return "❌ \(#function): Data Is E.M.P.T.Y"
        case .failOfImageConverting: return "❌ \(#function): Kakao webSearch result fail of image converting"
        }
    }
}
