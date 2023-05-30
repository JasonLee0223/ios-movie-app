//
//  DetailLoader.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

final class DetailLoader {
    
    //MARK: - Initializer
    
    init() {
        self.networkService = NetworkService()
    }
    
    //MARK: - Private Property
    
    private let networkService: NetworkService
}

extension DetailLoader {
    
    func loadMovieDetailInformation(movieCode: String) async throws -> TMDBMovieDetail {
        
        let movieDetailInformationQuryParameters = TMDBQueryParameters()
        
        guard let networkResult = try? await networkService.request(
            with: TMDBAPIEndPoint.receiveMovieDetail(
                with: movieDetailInformationQuryParameters, movieID: movieCode)
        ) else {
            throw DataLoadError.failOfMovieDetailInfromationData
        }
        return networkResult
    }
    
    func loadMovieCredit(movieCode: String) async throws -> TMDBMovieCredit {
        
        let movieCreditQueryParameters = TMDBQueryParameters()
        
        guard let networkResult = try? await networkService.request(
            with: TMDBAPIEndPoint.receiveCreditInformation(
                with: movieCreditQueryParameters, movieID: movieCode)
        ) else {
            throw DataLoadError.failOfMovieDetailInfromationData
        }
        return networkResult
    }
}


//https://api.themoviedb.org/3/movie/603692/credits?language=ko-KR&api_key=f24ca5e74fea9387e34b77fc5e0cda23
