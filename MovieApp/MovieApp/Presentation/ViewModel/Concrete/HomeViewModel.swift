//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

final class HomeViewModel {
    
//    init() {
//        self.homeLoader = HomeLoader()
//    }
//
//    private let homeLoader: HomeLoader
}

//MARK: - Use at TMDB
extension HomeViewModel {
    /// Top Method
//    func loadTrendOfWeekMovieListFromTMDB() async -> [TrendMovie] {
//        
//        var trendMovieListGroup = [TrendMovie]()
//        
//        do {
//            let networkResult = try await self.homeLoader.loadTrendMovieList()
//            
//            for result in networkResult {
//                let imageData = try await fetchImage(imagePath: result.movieImageURL)
//                let trendMovie = TrendMovie(movieCode: String(result.movieID),
//                    posterImage: imageData, posterName: result.movieKoreaTitle
//                )
//                trendMovieListGroup.append(trendMovie)
//            }
//        } catch {
//            print(HomeViewModelInError.failOfLoadToTrendMovieList)
//        }
//        return trendMovieListGroup
//    }
    
    /// Bottom Method
    private func fetchImage(imagePath: String) async throws -> Data {
        
        let imageURLPath = "\(TMDBBasic.imageURL)\(imagePath)"
        
        guard let imageURL = URL(string: imageURLPath) else {
            throw HomeViewModelInError.failOfMakeURL
        }
            
        guard let imageData = try? Data(contentsOf: imageURL) else {
            throw HomeViewModelInError.failOfMakeData
        }
        
        return imageData
    }
    
    func convertToMovieInformation(from networkResult: TMDBMovieDetail) throws -> MovieInformation {
        
        let wrappingMovieInformation: MovieInformation?
        
        var watchGrade: String = ""
        
        let nations = try networkResult.productionCountries.compactMap { countriesInfo in
            
            guard let country = StandardNationList(rawValue: countriesInfo.iso_3166_1) else {
                throw DetailViewModelInError.failedToFindCountryCode
            }
            let countryName = country.countryName
            return countryName
        }
        
        let genres = networkResult.genres.map { genre in
            genre.name
        }
        
        if !networkResult.adult {
            watchGrade = "전체 이용가"
        }
        
        wrappingMovieInformation = MovieInformation(
            identifier: UUID(),
            posterHeaderArea: PosterHeaderArea(
                watchGrade: watchGrade,
                movieKoreanName: networkResult.koreanTitle,
                movieEnglishName: networkResult.movieEnglishTitle
            ),
            
            nations: nations,
            genres: genres,
            
            subInformation: SubInformation(
                releaseDate: networkResult.releaseDate,
                runtime: String(networkResult.runtime) + " 분",
                overview: networkResult.overview
            )
        )
        
        guard let movieInformation = wrappingMovieInformation else {
            throw DetailViewModelInError.failOfUnwrapping
        }
        return movieInformation
    }
}
