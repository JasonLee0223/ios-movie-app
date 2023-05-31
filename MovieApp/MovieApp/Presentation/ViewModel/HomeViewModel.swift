//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

final class HomeViewModel {
    
    var sectionStorage: [HomeSectionList: Observable<HomeEntityWrapper>]
    
    init() {
        self.homeLoader = HomeLoader()
        
        self.sectionStorage = [.trendMoviePosterSection: Observable<HomeEntityWrapper>(),
                               .stillCutSection: Observable<HomeEntityWrapper>(),
                               .koreaMovieListSection: Observable<HomeEntityWrapper>()
                            ]
    }
    
    private let homeLoader: HomeLoader
}

//MARK: - [Public Method] Use at ViewController
extension HomeViewModel {
    
    func testTaskGroup(section: HomeSectionList) async {
        await withTaskGroup(of: [HomeEntityWrapper].self) { taskGroup in
            
            taskGroup.addTask { [self] in
                
                switch section {
                case .trendMoviePosterSection:
                    let movieList = await self.loadTrendOfWeekMovieListFromTMDB()
                    
                    let businessModelToTrendMovie = movieList.map { trendMovie in
                        HomeEntityWrapper.trendMovie(trendMovie)
                    }
                    sectionStorage[section]?.value = businessModelToTrendMovie
                    return businessModelToTrendMovie
                    
                case .stillCutSection:
                    let moiveNames = await loadMovieNameGroup()
                    let imageDatas = await kakaoPosterImageTest(movieNameGroup: moiveNames)
                    
                    let businessModelToStillCut = imageDatas.map { data in
                        HomeEntityWrapper.stillCut(StillCut(identifier: UUID(), genreImagePath: data))
                    }
                    sectionStorage[section]?.value = businessModelToStillCut
                    return businessModelToStillCut
                    
                case .koreaMovieListSection:
                    let koreaBoxOfficeMovieList = await loadKoreaBoxOfficeMovieList()
                    
                    let businessModelToKoreaBoxOfficeMovieList = koreaBoxOfficeMovieList.map { koreaBoxOfficeList in
                        HomeEntityWrapper.koreaBoxOfficeList(koreaBoxOfficeList)
                    }
                    sectionStorage[section]?.value = businessModelToKoreaBoxOfficeMovieList
                    return businessModelToKoreaBoxOfficeMovieList
                }
            }
            
        }
    }
    
    func fetchHomeCollectionViewSectionItemsRelated(be section: HomeSectionList) {
        /// Notice: Need HomeCollectionView Data
        /// 1. Array of TrendMovie
        /// 2. Array of StillCut
        /// 3. Array of KoreaBoxOfficeList
        
        switch section {
        case .trendMoviePosterSection:
            Task {
                let businessModelToTrendMovie = await loadTrendOfWeekMovieListFromTMDB().map { trendMovie in
                    HomeEntityWrapper.trendMovie(trendMovie)
                }
                self.sectionStorage[section]?.value = businessModelToTrendMovie
            }
        case .stillCutSection:
            Task {
                let stillCutPosterImageData = await kakaoPosterImageTest(movieNameGroup: loadMovieNameGroup())
                let businessModelToStillCut = stillCutPosterImageData.map { data in
                    HomeEntityWrapper.stillCut(StillCut(identifier: UUID(), genreImagePath: data))
                }
                self.sectionStorage[section]?.value = businessModelToStillCut
            }
        case .koreaMovieListSection:
            Task {
                try await Task.sleep(nanoseconds: 7_000_000_000)  // 5초 딜레이
                
                let koreaBoxOfficeMovieList = await loadKoreaBoxOfficeMovieList()
                let businessModelToKoreaBoxOfficeMovieList = koreaBoxOfficeMovieList.map { koreaBoxOfficeList in
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
                let trendMovie = TrendMovie(
                    identifier: UUID(), movieCode: String(result.movieID),
                    posterImage: imageData, posterName: result.movieKoreaTitle
                )
                trendMovieListGroup.append(trendMovie)
            }
        } catch {
            print("MovieList Fail")
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

//MARK: - [private] Use at KOFIC
extension HomeViewModel {
    
    /// KOFIC
    private func loadKoreaBoxOfficeMovieList() async -> [KoreaBoxOfficeList] {
        var dailyBoxOfficeListGroup = [DailyBoxOfficeList]()
        
        do {
            dailyBoxOfficeListGroup = try await homeLoader.loadDailyBoxOfficeMovieListData()
        } catch {
            print("dailyBoxOfficeListGroup convert fail")
        }
        
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
    
    private func loadMovieNameGroup() async -> [String] {
        var movieNames = [String]()
        
        do {
            movieNames = try await homeLoader.loadDailyBoxOfficeMovieListData().map{ $0.movieName }
        } catch {
            print("ViewModelInError.failOfMakeData")
        }
        return movieNames
    }
    
    private func loadMovieDetailInformation() async throws -> [MovieInfo] {
        let dailyBoxOfficeListGroup = try await homeLoader.loadDailyBoxOfficeMovieListData()
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
                print("Image 변환 실패")
            }
        }
        
        return imageDataStorage
    }
}
