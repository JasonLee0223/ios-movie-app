//
//  MakeURL.swift
//  MovieApp
//
//  Created by Jason on 2023/09/05.
//

import Foundation

enum MakeURL {
    case trendMovie(SubPath)
    case detail(String)
    case credit(String, SubPath)
    case boxOffice
    case posterImage(String)
    
    enum SubPath: String {
        case day = "day"
        case week = "week"
        case credit = "/credits"
    }
    
    var url: URL {
        switch self {
        case .trendMovie(let subPath):
            return URL(string: self.baseURL + subPath.rawValue)!
        case .detail(let movieCode):
            return URL(string: self.baseURL + movieCode)!
        case .credit(let movieCode, let subPath):
            return URL(string: self.baseURL + movieCode + subPath.rawValue)!
        case .boxOffice:
            return URL(string: self.baseURL + self.boxOfficeSubPath + self.format)!
        case .posterImage(let imagePath):
            return URL(string: self.baseURL + imagePath)!
        }
    }
    
    private var baseURL: String {
        switch self {
        case .trendMovie: return "https://api.themoviedb.org/3/trending/movie/"
        case .detail, .credit: return "https://api.themoviedb.org/3/movie/"
        case .boxOffice: return "https://www.kobis.or.kr/kobisopenapi/webservice/rest"
        case .posterImage: return "https://image.tmdb.org/t/p/original"
        }
    }
    
    private var movieCode: String {
        return "movieCd"
    }
    
    private var format: String {
        return ".json"
    }
    
    private var boxOfficeSubPath: String {
        return "/boxoffice" + "/searchDailyBoxOfficeList"
    }
    
    private var detailBoxOfficeSubPath: String {
        return "/movie" + "/searchMovieInfo"
    }
}
