//
//  TMDBAPIEndPoint.swift
//  MovieApp
//
//  Created by Jason on 2023/05/20.
//

import Foundation

struct TMDBAPIEndPoint {
    
    static func receiveWeakTrendingList(with weakMovieListRequestDTO: TMDBQueryParameters) -> EndPoint<TMDBTrendMovieList> {
        return EndPoint(baseURL: TVDBBasic.baseURL,
                        firstPath: TVDBBasic.pathQueryOfWeak,
                        queryParameters: weakMovieListRequestDTO
        )
    }
    
    static func receiveMovieDetail(with movieDetailRequestDTO: TMDBQueryParameters,
                                   movieID: String) -> EndPoint<TMDBMovieDetail> {
        return EndPoint(baseURL: TVDBBasic.movieDetailBaseURL,
                        firstPath: movieID,
                        queryParameters: movieDetailRequestDTO
        )
    }
}
