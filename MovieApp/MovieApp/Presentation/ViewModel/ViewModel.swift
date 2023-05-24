//
//  ViewModel.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

struct SectionViewModel<M> {
    var type: SectionList
    var products: [M]
}

final class ViewModel {
    
    var sectionStorage: [SectionList: Observable<TrendMovieList>]
    
    init() {
        self.networkService = NetworkService()
        
        self.sectionStorage = [.trendMoviePosterSection: Observable<TrendMovieList>(TrendMovieList(posterImagePath: "", posterName: ""))]
        
    }
    
    func countItem(section: Int) -> Int {
        
        let targetType = SectionList.allCases[section]          // sectionName = trendMoviePosterSection
        
        switch targetType {
        case .trendMoviePosterSection:
            
//            sectionStorage
            
            
//            print(count)
//            return count
            return 20
        case .stillCutSection:
            return 20
        case .koreaMovieListSection:
            return 20
        }
        
    }
    
    func loadTrendOfWeekMovieListFromTVDB(completion: @escaping ([TrendMovieList]) -> Void) {
        Task {
            self.networkService.loadTrendingMovieListData { resultStorage in
                
                let makeTrendMovieList = resultStorage.map { result in
                    TrendMovieList(posterImagePath: result.movieImageURL,
                                   posterName: result.movieKoreaTitle)
                }
                completion(makeTrendMovieList)
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
    
    func kakaoPosterImageTest(completion: @escaping (URL) -> Void) {
        
        let mockData = ["분노의 질주: 라이드 오어 다이", "스즈메의 문단속", "슬픔의 삼각형", "가디언즈 오브 갤럭시: Volume 3",
         "극장판 짱구는 못말려: 동물소환 닌자 배꼽수비대", "더 퍼스트 슬램덩크", "슈퍼 마리오 브라더스",
         "문재인입니다", "드림", "존 윅 4"]
        
        networkService.loadMoviePosterImage(movieNameGroup: mockData) { document in
            guard let imageURL = URL(string:document.imageURL) else {
                return
            }
            completion(imageURL)
        }
    }
    
    func test() {
        
        var movieInfoGroup = [MovieInfo]()
        
        networkService.loadDailyBoxOfficeData { dailyBoxOfficeListStorage in
            
            let movieCodegroup = dailyBoxOfficeListStorage.map{$0.movieCode}
            
            self.networkService.loadMovieDetailData(movieCodeGroup: movieCodegroup) { movieInfo in
                movieInfoGroup.append(movieInfo)
                print(movieInfo)
                //MARK: - 여기까지 MovieDetail 가져오는 로직 성공
            }
            
        }
    }
    
    private let networkService: NetworkService
}

//MARK: - ImageURL
//    let moviePosterPathGroup = resultStorage.map{ $0.movieImageURL }
//
//    if let makeImgaeURL = try? moviePosterPathGroup.map({ posterImagePath in
//        let imageURLPath = "\(TVDBBasic.imageURL)\(posterImagePath)"
//
//        guard let imageURL = URL(string: imageURLPath) else {
//            throw URLComponentsError.invalidComponent
//        }
//        return imageURL
//    }) {
//        imageURLGroup = makeImgaeURL
//        completion(imageURLGroup)
//    }
