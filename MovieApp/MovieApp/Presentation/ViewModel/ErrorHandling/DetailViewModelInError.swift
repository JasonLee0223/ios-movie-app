//
//  DetailViewModelInError.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

enum DetailViewModelInError: LocalizedError {
    case failOfUnwrapping
    case failOfLoadMovieInformation
    case failOfLoadMovieCast
    case failedToFindCountryCode
    
    var errorDescription: String? {
        switch self {
        case .failOfUnwrapping: return "❌ Fail Of UnWrapping"
        case .failOfLoadMovieInformation: return "❌ Fail Of Load MovieInformation"
        case .failOfLoadMovieCast: return "❌ Fail Of LoadMovieCast"
        case .failedToFindCountryCode: return "❌ 국가 코드에 해당하는 국가를 찾을 수 없습니다."
        }
    }
}
