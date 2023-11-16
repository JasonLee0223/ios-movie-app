//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

final class HomeViewModel {
    
    var sectionStorage: [HomeSection: Observable<HomeEntityWrapper>]
    
    init() {
        self.homeLoader = HomeLoader()
        
        self.sectionStorage = [
            .trendMoviePoster: Observable<HomeEntityWrapper>(),
            .stillCut: Observable<HomeEntityWrapper>(),
            .koreaMovieList: Observable<HomeEntityWrapper>()
        ]
    }
    
    private let homeLoader: HomeLoader
}

//MARK: - [Public Method] Use at ViewController
extension HomeViewModel {
    
    func fetchHomeCollectionViewSectionItemsRelated(be section: HomeSection) {
        
        switch section {
        case .trendMoviePoster:
            Task {
                let businessModelToTrendMovie = await loadTrendOfWeekMovieListFromTMDB().map { trendMovie in
                    HomeEntityWrapper.trendMovie(trendMovie)
                }
                self.sectionStorage[section]?.value = businessModelToTrendMovie
            }
        case .stillCut:
            Task {
                try await Task.sleep(nanoseconds: 7_000_000_000)
                async let stillCutPosterImageData = await kakaoPosterImageTest(movieNameGroup: loadMovieNameGroup())
                let businessModelToStillCut = await stillCutPosterImageData.map { data in
                    HomeEntityWrapper.stillCut(StillCut(genreImagePath: data))
                }
                self.sectionStorage[section]?.value = businessModelToStillCut
            }
        case .koreaMovieList:
            Task {
                try await Task.sleep(nanoseconds: 10_000_000_000)
                async let koreaBoxOfficeMovieList = await loadKoreaBoxOfficeMovieList()
                let businessModelToKoreaBoxOfficeMovieList = await koreaBoxOfficeMovieList.map { koreaBoxOfficeList in
                    HomeEntityWrapper.koreaBoxOfficeList(koreaBoxOfficeList)
                }
                self.sectionStorage[section]?.value = businessModelToKoreaBoxOfficeMovieList
            }
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
        
        let (imageData, _) = try await URLSession.shared.data(from: imageURL)
        return imageData
    }
}
 
//MARK: - [private] Use at KOFIC
extension HomeViewModel {
    
    /// KOFIC
    private func loadKoreaBoxOfficeMovieList() async -> [KoreaBoxOfficeList] {
        var dailyBoxOfficeListGroup = [DailyBoxOfficeList]()
        
        dailyBoxOfficeListGroup = await homeLoader.loadDailyBoxOfficeMovieListData()
        
        let koreaBoxOfficeMovieListGroup = dailyBoxOfficeListGroup.map { dailyBoxOfficeList in
            KoreaBoxOfficeList(
                openDate: dailyBoxOfficeList.openDate,
                rank: Rank(
                    rank: dailyBoxOfficeList.rank,
                    rankOldAndNew: dailyBoxOfficeList.rankOldAndNew,
                    rankVariation: dailyBoxOfficeList.rankVariation
                ),
                movieSummaryInformation: MovieSummaryInformation(
                    movieName: dailyBoxOfficeList.movieName,
                    audienceCount: dailyBoxOfficeList.audienceCount,
                    audienceAccumulated: dailyBoxOfficeList.audienceAccumulate
                )
            )
        }
        
        return koreaBoxOfficeMovieListGroup
    }
    
    private func loadMovieNameGroup() async -> [String] {
        var movieNames = [String]()
        
        movieNames = await homeLoader.loadDailyBoxOfficeMovieListData().map{ $0.movieName }
        return movieNames
    }
    
    private func loadMovieDetailInformation() async throws -> [MovieInfo] {
        let dailyBoxOfficeListGroup = await homeLoader.loadDailyBoxOfficeMovieListData()
        let movieCodeGroup = dailyBoxOfficeListGroup.map{ $0.movieCode }
        let movieDetailList = try await homeLoader.loadMovieDetailData(movieCodeGroup: movieCodeGroup)
        return movieDetailList
    }
}

//MARK: - [private] Use at Kakao
extension HomeViewModel {
    
    private func kakaoPosterImageTest(movieNameGroup: [String]) async -> [Data] {
        
        var documents = [Document]()
        var imageDataStorage = [Data]()
        
        do {
            documents = try await homeLoader.loadStillCut(movieNameGroup: movieNameGroup)
        } catch {
            print(HomeViewModelInError.failOfMakeData)
        }
        
        for document in documents {
            do {
                guard let imageURL = URL(string: document.imageURL) else {
                    throw HomeViewModelInError.failOfMakeURL
                }
                guard let imageData = try? Data(contentsOf: imageURL) else {
                    throw HomeViewModelInError.failOfMakeData
                }
                imageDataStorage.append(imageData)
            } catch {
                print(HomeViewModelInError.failOfImageConverting)
            }
        }
        
        return imageDataStorage
    }
}
