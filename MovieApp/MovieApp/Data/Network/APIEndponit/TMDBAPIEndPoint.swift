//
//  TMDBAPIEndPoint.swift
//  MovieApp
//
//  Created by Jason on 2023/05/20.
//

import Foundation

struct TMDBAPIEndPoint {
    
    static func receiveWeakTrendingList(with weakMovieListRequestDTO: TMDBQueryParameters) -> EndPoint<TMDBTrendMovieList> {
        return EndPoint(baseURL: TMDBBasic.trendMovieListBaseURL,
                        firstPath: TMDBBasic.pathQueryOfWeak,
                        queryParameters: weakMovieListRequestDTO
        )
    }
    
    static func receiveMovieDetail(with movieDetailRequestDTO: TMDBQueryParameters,
                                   movieID: String) -> EndPoint<TMDBMovieDetail> {
        return EndPoint(baseURL: TMDBBasic.movieDetailBaseURL,
                        firstPath: movieID,
                        queryParameters: movieDetailRequestDTO
        )
    }
    
    static func receiveCreditInformation(with movieCreditRequestDTO: TMDBQueryParameters,
                                         movieID: String) -> EndPoint<TMDBMovieCredit> {
        return EndPoint(baseURL: TMDBBasic.movieDetailBaseURL,
                        firstPath: movieID, secondPath: TMDBBasic.pathQueryOfCredit,
                        queryParameters: movieCreditRequestDTO
        )
    }
}
