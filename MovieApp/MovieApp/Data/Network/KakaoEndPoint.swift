//
//  KakaoEndPoint.swift
//  MovieApp
//
//  Created by Jason on 2023/05/22.
//

import Foundation

struct KakaoEndPoint {
    
    static func receiveMoviePosterImage(with kakaoImageRequestDTO: KoreaMovieListImageQueryParameters) -> EndPoint<MoviePosterImage> {
        return EndPoint(baseURL: KakaoBasic.baseURL,
                        firstPath: KakaoBasic.image,
                        queryParameters: KakaoBasic.query,
                        headers: KakaoBasic.headers
        )
    }
}
