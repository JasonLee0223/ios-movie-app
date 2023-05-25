//
//  ViewModel.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

struct SectionViewModel {
    var type: SectionList
    var items: [BusinessModelWrapper]
}

final class ViewModel {
    
    var sectionStorage: [SectionList: Observable<SectionViewModel>]
    
    init() {
        self.networkService = NetworkService()
        
        self.sectionStorage = [.trendMoviePosterSection: Observable<SectionViewModel>(),
                               .stillCutSection: Observable<SectionViewModel>(),
                               .koreaMovieListSection: Observable<SectionViewModel>()
                            ]
    }
    
    private let networkService: NetworkService
}

//MARK: - Use at TMDB
extension ViewModel {
    func loadTrendOfWeekMovieListFromTVDB(completion: @escaping ([TrendMovie]) -> Void) {
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
    
    func fetchImage(imagePath: String, completion: @escaping (Data) -> Void) {
        
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

//MARK: - Use at KoreaMovie
extension ViewModel {
    
    func kakaoPosterImageTest(movieName: [String], completion: @escaping (Data) -> Void) {
        
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

//MARK: - Use at Kakao
extension ViewModel {
    
    func loadKoreaBoxOfficeMovieList(completion: @escaping ([MovieInfo], [StillCut], [KoreaBoxOfficeList]) -> Void) {
        
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

//MARK: - Count Method
extension ViewModel {
    
    func countSection() -> Int {
        return self.sectionStorage.count
    }
    
    func countItem(section: Int) -> Int {
        let targetType = SectionList.allCases[section]
        
        guard let items = sectionStorage[targetType]?.value?.items else { return 0 }
        return items.count
    }
}
