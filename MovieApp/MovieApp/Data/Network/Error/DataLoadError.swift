//
//  DataLoadError.swift
//  MovieApp
//
//  Created by Jason on 2023/05/26.
//

import Foundation

enum DataLoadError: LocalizedError {
    case loadFailOfTrendMovieListData
    case loadFailOfMovieDetailInfromationData
    case loadFailOfMovieCreditsData
    case loadFailOfBoxOfficeList
    
    var errorDescription: String? {
        switch self {
        case .loadFailOfTrendMovieListData: return "❌ Fail Of TrendMovieListData"
        case .loadFailOfMovieDetailInfromationData: return "❌ Fail Of MovieDetailInfromationData"
        case .loadFailOfMovieCreditsData: return "❌ Fail Of MovieCreditsData"
        case .loadFailOfBoxOfficeList: return "❌ Fail Of KoreaBoxOfficeMovieListData"
        }
    }
}
