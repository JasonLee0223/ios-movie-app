//
//  HomeLoader.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

final class HomeLoader {
    
    //MARK: - Initializer
    
    init() {
        self.networkService = NetworkService()
    }
    
    //MARK: - Private Property
    
    private let networkService: NetworkService
}

//MARK: - [Public Method] Use of async & await
extension HomeLoader {
    
    /// TrendMovieList
    func loadTrendMovieList() async throws -> [Result] {
        
        let popularMovieListQueryParameters = TMDBQueryParameters()
        
        guard let networkResult = try? await networkService.request(
            with: TMDBAPIEndPoint.receiveWeakTrendingList(
                with: popularMovieListQueryParameters)
        ).results else {
            throw DataLoadError.failOfTrendMovieListData
        }
        return networkResult
    }
    
    /// StillCut
    func loadStillCut(movieNameGroup: [String]) async throws -> [Document] {
        let moviePosterImageParametersGroup = movieNameGroup.map { movieName in
            KoreaMovieListImageQueryParameters(query: movieName)
        }
        
        var networkResult = [Document]()
        
        for moviePosterImageParameters in moviePosterImageParametersGroup {
            
            do {
                var result = try await networkService.request(
                    with: KakaoEndPoint.receiveMoviePosterImage(
                        with: moviePosterImageParameters)).documents
                let bestResult = result.removeFirst()
                networkResult.append(bestResult)
            } catch {
                throw DataLoadError.failOfStillCutData
            }
        }
        return networkResult
    }
    
    /// KoreaBoxOfficeMovieList
    func loadDailyBoxOfficeMovieListData() async -> [DailyBoxOfficeList] {
        let yesterdayDate = Getter.receiveCurrentDate.split(separator: "-").joined()
        let boxOfficeQueryParameters = BoxOfficeQueryParameters(targetDate: yesterdayDate)
        
        var networkResult = [DailyBoxOfficeList]()
        do {
            networkResult = try await networkService.request(
                with: KOFICAPIEndPoint.receiveBoxOffice(
                    with: boxOfficeQueryParameters)
            ).boxOfficeResult.dailyBoxOfficeList
        } catch {
            print(DataLoadError.failOfkoreaBoxOfficeMovieListData)
        }
        
        return networkResult
    }
    
    func loadMovieDetailData(movieCodeGroup: [String]) async throws -> [MovieInfo] {
        
        let movieDetailQueryParametersGroup = movieCodeGroup.map { movieCode in
            MovieDetailQueryParameters(movieCode: movieCode)
        }
        
        var networkResult = [MovieInfo]()
        for movieDetailQueryParameters in movieDetailQueryParametersGroup {
            
            do {
                let result = try await networkService.request(
                    with: KOFICAPIEndPoint.receiveMovieDetailInformation(
                        with: movieDetailQueryParameters)
                ).movieInfoResult.movieInfo
                networkResult.append(result)
            } catch {
                throw DataLoadError.failOfMovieDetailInfromationData
            }
        }
        
        return networkResult
    }
}

//MARK: - [Public Method] Use of CompletionHandler
extension HomeLoader {
    
    /// TrendMovieList
    func loadTrendingMovieListData(completion: @escaping ([Result]) -> Void) {
        
        Task {
            let popularMovieListQueryParameters = TMDBQueryParameters()
            let networkResult = try await networkService.request(
                with: TMDBAPIEndPoint.receiveWeakTrendingList(
                    with: popularMovieListQueryParameters)
            ).results
            
            completion(networkResult)
        }
    }
    
    /// StillCut
    func loadMoviePosterImage(movieNameGroup: [String], completion: @escaping (Document) -> Void) {
        
        movieNameGroup.forEach { movieName in
            
            Task {
                let moviePosterImageParameters = KoreaMovieListImageQueryParameters(query: movieName)
                var networkResult = try await networkService.request(
                    with: KakaoEndPoint.receiveMoviePosterImage(
                        with: moviePosterImageParameters)
                ).documents
                
                completion(networkResult.removeFirst())
            }
        }
    }
    
    /// KoreaBoxOfficeMovieList
    func loadDailyBoxOfficeData(completion: @escaping ([DailyBoxOfficeList]) -> Void) {
        
        Task {
            let yesterdayDate = Getter.receiveCurrentDate.split(separator: "-").joined()
            let boxOfficeQueryParameters = BoxOfficeQueryParameters(targetDate: yesterdayDate)
            let swapResult = try await networkService.request(
                with: KOFICAPIEndPoint.receiveBoxOffice(
                    with: boxOfficeQueryParameters)
            ).boxOfficeResult.dailyBoxOfficeList
            
            completion(swapResult)
        }
    }
    
    func loadMovieDetailData(movieCodeGroup: [String], completion: @escaping (MovieInfo) -> Void) {
        
        movieCodeGroup.forEach { movieCode in
            
            Task {
                let movieDetailQueryParameters = MovieDetailQueryParameters(movieCode: movieCode)
                let networkResult = try await networkService.request(
                    with: KOFICAPIEndPoint.receiveMovieDetailInformation(
                        with: movieDetailQueryParameters)
                ).movieInfoResult.movieInfo
                
                completion(networkResult)
            }
        }
    }
}
