//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

final class DetailViewModel {
    
    init() {
        self.detailLoader = DetailLoader()
    }
    
    private let detailLoader: DetailLoader
}

extension DetailViewModel {
    
    private func loadSelectedMovieDetailInformation(movieCode: String) async throws -> MovieInformation {
        
        var wrappingMovieInformation: MovieInformation?
        
        do {
            let networkResult = try await self.detailLoader.loadMovieDetailInformation(movieCode: movieCode)
            
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
                movieSummary: MovieSummary(
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
        } catch {
            throw DetailViewModelInError.failOfLoadMovieInformation
        }
        
        guard let movieInformation = wrappingMovieInformation else {
            throw DetailViewModelInError.failOfUnWrapping
        }
        
        return movieInformation
    }
}
