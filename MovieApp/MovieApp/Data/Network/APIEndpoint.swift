//
//  APIEndpoint.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct APIEndPoint {

    static func receiveBoxOffice(with boxOfficeRequestDTO: BoxOfficeQueryParameters) -> EndPoint<BoxOffice> {
        return EndPoint(baseURL: Basic.baseURL,
                        firstPath: Show.boxOffice,
                        secondPath: Show.searchDailyList,
                        queryParameters: boxOfficeRequestDTO)
    }

    static func receiveMovieDetailInformation(with movieDetailRequestDTO: MovieDetailQueryParameters) -> EndPoint<MovieDetailInformation> {
        return EndPoint(baseURL: Basic.baseURL,
                        firstPath: Movie.category,
                        secondPath: Movie.searchMovieInfo,
                        queryParameters: movieDetailRequestDTO)
    }
}
