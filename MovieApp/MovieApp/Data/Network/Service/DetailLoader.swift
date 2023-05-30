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

//MARK: - [Public Method] Use at DetailViewModel
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
    
    //TODO: - HomeViewModel과 동일한 메서드로 중복 제거 요망
    func fetchImage(imagePath: String) throws -> Data {
        
        let imageURLPath = "\(TMDBBasic.imageURL)\(imagePath)"
        
        guard let imageURL = URL(string: imageURLPath) else {
            throw HomeViewModelInError.failOfMakeURL
        }
            
        guard let imageData = try? Data(contentsOf: imageURL) else {
            throw HomeViewModelInError.failOfMakeData
        }
        
        return imageData
    }
    
    func convertToMovieInformation(
        from networkResult: TMDBMovieDetail) throws -> MovieInformation {
            
            let wrappingMovieInformation: MovieInformation?
        
            var watchGrade: String = ""
            
            let nations = networkResult.productionCountries.map { countriesInfo in
                countriesInfo.name
            }
            
            let genres = networkResult.genres.map { genre in
                genre.name
            }
            
            if !networkResult.adult {
                watchGrade = "전체 이용가"
            }
            
            wrappingMovieInformation = MovieInformation(
                identifier: UUID(),
                movieSummary: PosterHeaderArea(
                    watchGrade: watchGrade,
                    movieKoreanName: networkResult.koreanTitle,
                    movieEnglishName: networkResult.movieEnglishTitle
                ),
                
                nations: nations,
                genres: genres,
                
                subInformation: SubInformation(
                    releaseDate: networkResult.releaseDate,
                    runtime: String(networkResult.runtime),
                    overview: networkResult.overview
                )
            )
            
            guard let movieInformation = wrappingMovieInformation else {
                throw DetailViewModelInError.failOfUnWrapping
            }
            return movieInformation
    }
}
