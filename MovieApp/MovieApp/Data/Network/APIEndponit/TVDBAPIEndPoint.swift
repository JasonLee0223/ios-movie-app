//
//  TVDBAPIEndPoint.swift
//  MovieApp
//
//  Created by Jason on 2023/05/20.
//

import Foundation

struct TVDBAPIEndPoint {
    
    static func receiveWeakTrendingList(with weakMovieListRequestDTO: TMDBQueryParameters) -> EndPoint<TMDBPopular> {
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
