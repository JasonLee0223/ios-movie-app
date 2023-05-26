//
//  KOFICAPIEndPoint.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct KOFICAPIEndPoint {

    static func receiveBoxOffice(with boxOfficeRequestDTO: BoxOfficeQueryParameters) -> EndPoint<BoxOffice> {
        return EndPoint(baseURL: KOFICBasic.baseURL,
                        firstPath: Show.boxOffice,
                        secondPath: Show.searchDailyList,
                        queryParameters: boxOfficeRequestDTO)
    }

    static func receiveMovieDetailInformation(with movieDetailRequestDTO: MovieDetailQueryParameters) -> EndPoint<MovieDetailInformation> {
        return EndPoint(baseURL: KOFICBasic.baseURL,
                        firstPath: Movie.category,
                        secondPath: Movie.searchMovieInfo,
                        queryParameters: movieDetailRequestDTO)
    }
}
