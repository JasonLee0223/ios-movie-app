//
//  DataLoadError.swift
//  MovieApp
//
//  Created by Jason on 2023/05/26.
//

import Foundation

enum DataLoadError: LocalizedError {
    case failOfMovieDetailInfromationData
    case failOfTrendMovieListData
    case failOfMovieCreditsData
    case loadFailOfBoxOfficeList
    
    var errorDescription: String? {
        switch self {
        case .failOfMovieDetailInfromationData: return "❌ Fail Of MovieDetailInfromationData"
        case .failOfTrendMovieListData: return "❌ Fail Of TrendMovieListData"
        case .failOfMovieCreditsData: return "❌ Fail Of MovieCreditsData"
        case .loadFailOfBoxOfficeList: return "❌ Fail Of KoreaBoxOfficeMovieListData"
        }
    }
}
