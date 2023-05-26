//
//  ViewModel.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

final class ViewModel {
    
    var sectionStorage: [SectionList: Observable<BusinessModelWrapper>]
    
    init() {
        self.networkService = NetworkService()
        
        self.sectionStorage = [.trendMoviePosterSection: Observable<BusinessModelWrapper>(),
                               .stillCutSection: Observable<BusinessModelWrapper>(),
                               .koreaMovieListSection: Observable<BusinessModelWrapper>()
                            ]
    }
    
    private let networkService: NetworkService
}

//MARK: - Public Method
extension ViewModel {
    
    func fetchHomeCollectionViewSectionItemsRelated(be section: SectionList) {
        /// Notice: Need HomeCollectionView Data
        /// 1. Array of TrendMovie
        /// 2. Array of StillCut
        /// 3. Array of KoreaBoxOfficeList
        
        switch section {
        case .trendMoviePosterSection:
            Task {
                let businessModelToTrendMovie = try await loadTrendOfWeekMovieListFromTMDB().map { trendMovie in
                    BusinessModelWrapper.trendMovie(trendMovie)
                }
                self.sectionStorage[section]?.value = businessModelToTrendMovie
            }
        case .stillCutSection:
            Task {
                let stillCutPosterImageData = try await kakaoPosterImageTest(movieNameGroup: loadMovieNameGroup())
                let businessModelToStillCut = stillCutPosterImageData.map { data in
                    BusinessModelWrapper.stillCut(StillCut(identifier: UUID(), genreImagePath: data))
                }
                self.sectionStorage[section]?.value = businessModelToStillCut
            }
        case .koreaMovieListSection:
            Task {
                let koreaBoxOfficeMovieList = try await loadKoreaBoxOfficeMovieList()
                let businessModelToKoreaBoxOfficeMovieList = koreaBoxOfficeMovieList.map { koreaBoxOfficeList in
                    BusinessModelWrapper.koreaBoxOfficeList(koreaBoxOfficeList)
                }
                self.sectionStorage[section]?.value = businessModelToKoreaBoxOfficeMovieList
            }
        }
    }
}

//MARK: - [private] Use at TMDB
extension ViewModel {
    /// Top Method
    private func loadTrendOfWeekMovieListFromTMDB() async throws -> [TrendMovie] {
        let networkResult = try await self.networkService.loadTrendMovieList()
        
        var trendMovieListGroup = [TrendMovie]()
        
        for result in networkResult {
            let imageData = try await fetchImage(imagePath: result.movieImageURL)
            let trendMovie = TrendMovie(identifier: UUID(), posterImage: imageData, posterName: result.movieKoreaTitle)
            trendMovieListGroup.append(trendMovie)
        }
        return trendMovieListGroup
    }
    /// Bottom Method
    private func fetchImage(imagePath: String) async throws -> Data {
        
        let imageURLPath = "\(TVDBBasic.imageURL)\(imagePath)"
        
        guard let imageURL = URL(string: imageURLPath) else {
            throw ViewModelInError.failOfMakeURL
        }
            
        guard let imageData = try? Data(contentsOf: imageURL) else {
            throw ViewModelInError.failOfMakeData
        }
        
        return imageData
    }
}

//MARK: - [private] Use at KOFIC
extension ViewModel {
    
    /// KOFIC
    private func loadKoreaBoxOfficeMovieList() async throws -> [KoreaBoxOfficeList] {
        let dailyBoxOfficeListGroup = try await networkService.loadDailyBoxOfficeMovieListData()
        
        let koreaBoxOfficeMovieListGroup = dailyBoxOfficeListGroup.map { dailyBoxOfficeList in
            KoreaBoxOfficeList(
                identifier: UUID(),
                openDate: dailyBoxOfficeList.openDate,
                rank: Rank(
                    identifier: UUID(),
                    rank: dailyBoxOfficeList.rank,
                    rankOldAndNew: dailyBoxOfficeList.rankOldAndNew,
                    rankVariation: dailyBoxOfficeList.rankVariation
                ),
                movieSummaryInformation: MovieSummaryInformation(
                    identifier: UUID(),
                    movieName: dailyBoxOfficeList.movieName,
                    audienceCount: dailyBoxOfficeList.audienceCount,
                    audienceAccumulated: dailyBoxOfficeList.audienceAccumulate
                )
            )
        }
        
        return koreaBoxOfficeMovieListGroup
    }
    
    private func loadMovieNameGroup() async throws -> [String] {
        return try await networkService.loadDailyBoxOfficeMovieListData().map{ $0.movieName }
    }
    
    private func loadMovieDetailInformation() async throws -> [MovieInfo] {
        let dailyBoxOfficeListGroup = try await networkService.loadDailyBoxOfficeMovieListData()
        let movieCodeGroup = dailyBoxOfficeListGroup.map{ $0.movieCode }
        let movieDetailList = try await networkService.loadMovieDetailData(movieCodeGroup: movieCodeGroup)
        return movieDetailList
    }
}

//MARK: - [private] Use at Kakao
extension ViewModel {
    
    private func kakaoPosterImageTest(movieNameGroup: [String]) async throws -> [Data] {
        
        let networkResult = try await networkService.loadStillCut(movieNameGroup: movieNameGroup)
        
        var imageDataStorage = [Data]()
        
        for result in networkResult {
            guard let imageURL = URL(string:result.imageURL) else {
                throw ViewModelInError.failOfMakeURL
            }
            
            guard let imageData = try? Data(contentsOf: imageURL) else {
                throw ViewModelInError.failOfMakeData
            }
            imageDataStorage.append(imageData)
        }
        return imageDataStorage
    }
}
