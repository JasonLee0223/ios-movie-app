//
//  TVDBAPIEndPoint.swift
//  MovieApp
//
//  Created by Jason on 2023/05/20.
//

import Foundation

struct TVDBAPIEndPoint {
    
    static func receiveWeakTrendingList(with weakMovieListRequestDTO: PopularQueryParameters) -> EndPoint<TVDBPopular> {
        return EndPoint(baseURL: TVDBBasic.baseURL,
                        firstPath: TVDBBasic.pathQueryOfWeak,
                        queryParameters: weakMovieListRequestDTO)
    }
}
