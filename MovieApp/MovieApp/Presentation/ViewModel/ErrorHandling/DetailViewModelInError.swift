//
//  DetailViewModelInError.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

enum DetailViewModelInError: LocalizedError {
    case failOfUnWrapping
    case failOfLoadMovieInformation
    case failOfLoadMovieCast
    
    var errorDescription: String? {
        switch self {
        case .failOfUnWrapping: return "❌ Fail Of UnWrapping"
        case .failOfLoadMovieInformation: return "❌ Fail Of Load MovieInformation"
        case .failOfLoadMovieCast: return "❌ Fail Of LoadMovieCast"
        }
    }
}
