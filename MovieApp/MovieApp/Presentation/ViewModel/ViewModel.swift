//
//  ViewModel.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

final class ViewModel {
    
    var sectionStorage: [HomeSectionList: Observable<BusinessModelWrapper>]
    
    init() {
        self.networkService = NetworkService()
        
        self.sectionStorage = [.trendMoviePosterSection: Observable<BusinessModelWrapper>(),
                               .stillCutSection: Observable<BusinessModelWrapper>(),
                               .koreaMovieListSection: Observable<BusinessModelWrapper>()
                            ]
    }
    
    private let networkService: NetworkService
}


//func test() async {
//    // starts a new scope that can contain a dynamic number of child task
//    await withTaskGroup(of: Data.self) { taskGroup in                         // TaskGroup을 생성함, await은 위 함수가 비동기로 실행되기위함
//        let photoNames = await listPhotos(inGallery: "Summer Vacation")       // 이미지 다운로드를 위한 기본 준비 (내 상황에서는 movieNames)
//        for name in photoNames {                                              // movieName을 돌면서 addTask를 통해 일을 수행
//            taskGroup.addTask {
//                await self.downloadPhotos(name: name).data(using: .utf8)!
//            }
//        }
//    }
//}

//MARK: - Public Method
extension ViewModel {
    
    func testTaskGroup(section: HomeSectionList) async {
        await withTaskGroup(of: [BusinessModelWrapper].self) { taskGroup in
            
            taskGroup.addTask { [self] in
                
                switch section {
                case .trendMoviePosterSection:
                    let movieList = await self.loadTrendOfWeekMovieListFromTMDB()
                    
                    let businessModelToTrendMovie = movieList.map { trendMovie in
                        BusinessModelWrapper.trendMovie(trendMovie)
                    }
                    sectionStorage[section]?.value = businessModelToTrendMovie
                    return businessModelToTrendMovie
                    
                case .stillCutSection:
                    let moiveNames = await loadMovieNameGroup()
                    let imageDatas = await kakaoPosterImageTest(movieNameGroup: moiveNames)
                    
                    let businessModelToStillCut = imageDatas.map { data in
                        BusinessModelWrapper.stillCut(StillCut(identifier: UUID(), genreImagePath: data))
                    }
                    sectionStorage[section]?.value = businessModelToStillCut
                    return businessModelToStillCut
                    
                case .koreaMovieListSection:
                    let koreaBoxOfficeMovieList = await loadKoreaBoxOfficeMovieList()
                    
                    let businessModelToKoreaBoxOfficeMovieList = koreaBoxOfficeMovieList.map { koreaBoxOfficeList in
                        BusinessModelWrapper.koreaBoxOfficeList(koreaBoxOfficeList)
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
                    BusinessModelWrapper.trendMovie(trendMovie)
                }
                self.sectionStorage[section]?.value = businessModelToTrendMovie
            }
        case .stillCutSection:
            Task {
                let stillCutPosterImageData = await kakaoPosterImageTest(movieNameGroup: loadMovieNameGroup())
                let businessModelToStillCut = stillCutPosterImageData.map { data in
                    BusinessModelWrapper.stillCut(StillCut(identifier: UUID(), genreImagePath: data))
                }
                self.sectionStorage[section]?.value = businessModelToStillCut
            }
        case .koreaMovieListSection:
            Task {
                try await Task.sleep(nanoseconds: 10_000_000_000)  // 5초 딜레이
                
                let koreaBoxOfficeMovieList = await loadKoreaBoxOfficeMovieList()
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
    private func loadTrendOfWeekMovieListFromTMDB() async -> [TrendMovie] {
        
        var trendMovieListGroup = [TrendMovie]()
        
        do {
            let networkResult = try await self.networkService.loadTrendMovieList()
            
            for result in networkResult {
                let imageData = try await fetchImage(imagePath: result.movieImageURL)
                let trendMovie = TrendMovie(identifier: UUID(),
                                            posterImage: imageData,
                                            posterName: result.movieKoreaTitle
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
    private func loadKoreaBoxOfficeMovieList() async -> [KoreaBoxOfficeList] {
        var dailyBoxOfficeListGroup = [DailyBoxOfficeList]()
        
        do {
            dailyBoxOfficeListGroup = try await networkService.loadDailyBoxOfficeMovieListData()
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
            movieNames = try await networkService.loadDailyBoxOfficeMovieListData().map{ $0.movieName }
        } catch {
            print("ViewModelInError.failOfMakeData")
        }
        return movieNames
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
    
    private func kakaoPosterImageTest(movieNameGroup: [String]) async -> [Data] {
        
        var documents = [Document]()
        var imageDataStorage = [Data]()
        
        do {
            documents = try await networkService.loadStillCut(movieNameGroup: movieNameGroup)
        } catch {
            print(ViewModelInError.failOfMakeData)
        }
        
        for document in documents {
            do {
                guard let imageURL = URL(string: document.imageURL) else {
                    throw ViewModelInError.failOfMakeURL
                }
                guard let imageData = try? Data(contentsOf: imageURL) else {
                    throw ViewModelInError.failOfMakeData
                }
                imageDataStorage.append(imageData)
            } catch {
                print("Image 변환 실패")
            }
        }
        
        return imageDataStorage
    }
}
