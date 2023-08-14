//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

final class HomeViewModel {
    
    init() {
        self.homeLoader = HomeLoader()
    }
    
    private let homeLoader: HomeLoader
}

//MARK: - [Public Method] Use at ViewController
extension HomeViewModel {
    
    func fetchHomeCollectionViewSectionItemsRelated(be section: HomeSection) {
        
        Task {
            let businessModelToTrendMovie = await loadTrendOfWeekMovieListFromTMDB().map { trendMovie in
//                HomeEntityWrapper.trendMovie(trendMovie)
            }
//            self.sectionStorage[section]?.value = businessModelToTrendMovie
        }
    }
}

//MARK: - [private] Use at TMDB
extension HomeViewModel {
    /// Top Method
    private func loadTrendOfWeekMovieListFromTMDB() async -> [TrendMovie] {
        
        var trendMovieListGroup = [TrendMovie]()
        
        do {
            let networkResult = try await self.homeLoader.loadTrendMovieList()
            
            for result in networkResult {
                let imageData = try await fetchImage(imagePath: result.movieImageURL)
                let trendMovie = TrendMovie(movieCode: String(result.movieID),
                    posterImage: imageData, posterName: result.movieKoreaTitle
                )
                trendMovieListGroup.append(trendMovie)
            }
        } catch {
            print(HomeViewModelInError.failOfLoadToTrendMovieList)
        }
        return trendMovieListGroup
    }
    
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
}
