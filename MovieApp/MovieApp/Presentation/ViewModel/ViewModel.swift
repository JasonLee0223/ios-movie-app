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
    
    func fetchHomeCollectionViewSectionItemsRelated(be section: SectionList, completion: @escaping ([BusinessModelWrapper]) -> Void) {
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
                completion(businessModelToTrendMovie)
            }
        case .stillCutSection:
            Task {
                let stillCutPosterImageData = try await kakaoPosterImageTest(movieNameGroup: loadMovieNameGroup())
                let businessModelToStillCut = stillCutPosterImageData.map { data in
                    BusinessModelWrapper.stillCut(StillCut(identifier: UUID(), genreImagePath: data))
                }
                completion(businessModelToStillCut)
            }
        case .koreaMovieListSection:
            Task {
                let koreaBoxOfficeMovieList = try await loadKoreaBoxOfficeMovieList()
                let businessModelToKoreaBoxOfficeMovieList = koreaBoxOfficeMovieList.map { koreaBoxOfficeList in
                    BusinessModelWrapper.koreaBoxOfficeList(koreaBoxOfficeList)
                }
                completion(businessModelToKoreaBoxOfficeMovieList)
            }
        }
    }
    
    func fetchAllBusinessModel(completion: @escaping ([BusinessModelWrapper]) -> Void) {
        
        loadTrendOfWeekMovieListFromTVDB { trendMovieGroup in
            
            let trendMovieListConvertedToBusinessModel = trendMovieGroup.map { trendMovie in
                BusinessModelWrapper.trendMovie(trendMovie)
            }
            print("현재 trendMovieListConvertedToBusinessModel")
            print("\(trendMovieListConvertedToBusinessModel)")
            completion(trendMovieListConvertedToBusinessModel)
        }
        
        loadKoreaBoxOfficeMovieList { movieInfoGroup, stillCutGroup, koreaBoxOfficeListGroup in
            //TODO: - 추후 MovieDetailInfo로 사용할 타입 Mapping
//            let movieInfoGroupConvertedToBusinessModel = movieInfoGroup.map { movieInfo in
//                BusinessModelWrapper.movieInfo
//            }
            let stillCutConvertedToBusinessModel = stillCutGroup.map { stillCut in
                BusinessModelWrapper.stillCut(stillCut)
            }
            print("현재 stillCutConvertedToBusinessModel")
            print("\(stillCutConvertedToBusinessModel)")
            completion(stillCutConvertedToBusinessModel)
            
            let koreaBoxOfficeListConvertedToBusinessModel = koreaBoxOfficeListGroup.map { koreaBoxOfficeList in
                BusinessModelWrapper.koreaBoxOfficeList(koreaBoxOfficeList)
            }
            print("현재 koreaBoxOfficeListConvertedToBusinessModel")
            print("\(koreaBoxOfficeListConvertedToBusinessModel)")
            completion(koreaBoxOfficeListConvertedToBusinessModel)
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
    
    private func loadTrendOfWeekMovieListFromTVDB(completion: @escaping ([TrendMovie]) -> Void) {
        Task {
            self.networkService.loadTrendingMovieListData { resultStorage in
                
                var trendMovieList: [TrendMovie] = []
                
                for result in resultStorage {
                    self.fetchImage(imagePath: result.movieImageURL) { data in
                        trendMovieList.append(TrendMovie(identifier: UUID(), posterImage: data, posterName: result.movieKoreaTitle))
                    }
                }
                completion(trendMovieList)
            }
        }
    }
    
    private func fetchImage(imagePath: String, completion: @escaping (Data) -> Void) {
        
        DispatchQueue.global().async {
            let imageURLPath = "\(TVDBBasic.imageURL)\(imagePath)"
            guard let imageURL = URL(string: imageURLPath) else {
                return
            }
            
            guard let imageData = try? Data(contentsOf: imageURL) else {
                return
            }
            completion(imageData)
        }
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
    
    /// Origin Method
    private func loadKoreaBoxOfficeMovieList(completion: @escaping ([MovieInfo], [StillCut], [KoreaBoxOfficeList]) -> Void) {
        
        var movieInfoGroup = [MovieInfo]()
        var stillCutGroup = [StillCut]()
        var koreaBoxOfficeGroup = [KoreaBoxOfficeList]()
        
        networkService.loadDailyBoxOfficeData { dailyBoxOfficeListStorage in
            
            let movieCodeGroup = dailyBoxOfficeListStorage.map{ $0.movieCode }
            let movieNameGroup = dailyBoxOfficeListStorage.map{ $0.movieName }
            
            let koreaBoxOfficeListGroup = dailyBoxOfficeListStorage.map { dailyBoxOfficeList in
                KoreaBoxOfficeList(
                    identifier: UUID(), openDate: dailyBoxOfficeList.openDate,
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
            
            self.kakaoPosterImageTest(movieName: movieNameGroup) { data in
                stillCutGroup.append(.init(identifier: UUID(), genreImagePath: data))
            }
            
            self.networkService.loadMovieDetailData(movieCodeGroup: movieCodeGroup) { movieInfo in
                movieInfoGroup.append(movieInfo)
            }
            koreaBoxOfficeGroup = koreaBoxOfficeListGroup
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            completion(movieInfoGroup, stillCutGroup, koreaBoxOfficeGroup)
        }
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
    
    private func kakaoPosterImageTest(movieName: [String], completion: @escaping (Data) -> Void) {
        
        networkService.loadMoviePosterImage(movieNameGroup: movieName) { document in
            guard let imageURL = URL(string:document.imageURL) else {
                return
            }
            
            guard let imageData = try? Data(contentsOf: imageURL) else {
                return
            }
            completion(imageData)
        }
    }
}
