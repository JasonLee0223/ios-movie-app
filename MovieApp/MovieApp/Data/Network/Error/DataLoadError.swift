//
//  DataLoadError.swift
//  MovieApp
//
//  Created by Jason on 2023/05/26.
//

import Foundation

enum DataLoadError: LocalizedError {
    case failOfkoreaBoxOfficeMovieListData
    case failOfMovieDetailInfromationData
    case failOfStillCutData
    case failOfTrendMovieListData
    case failOfMovieCreditsData
    
    var errorDescription: String? {
        switch self {
        case .failOfkoreaBoxOfficeMovieListData: return "❌ Fail Of KoreaBoxOfficeMovieListData"
        case .failOfMovieDetailInfromationData: return "❌ Fail Of MovieDetailInfromationData"
        case .failOfStillCutData: return "❌ Fail Of StillCutData"
        case .failOfTrendMovieListData: return "❌ Fail Of TrendMovieListData"
        case .failOfMovieCreditsData: return "❌ Fail Of MovieCreditsData"
        }
    }
}
