//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation
import RxSwift

extension HomeViewModel: ViewModel {
    
    // 화면에 렌더링 될 속성들을 가지는 불변 객체 - Subject
    struct State {
        // 프로퍼티
        let trendMovieList = BehaviorSubject<[TrendMovie]>(value: [])
        let userRequestTrendType = PublishSubject<MakeURL.SubPath>()
        let imagePath = PublishSubject<String>()
    }
    
    // 상태를 바꾸는 명령 - AnyObserver
    struct Action {
        let loadData: AnyObserver<MakeURL.SubPath>
    }
}

final class HomeViewModel: Gettable {
    
    var state: State
    var action: Action
    
    init() {
        let loadDataSubject = PublishSubject<MakeURL.SubPath>()
        
        self.state = State()
        self.action = Action(loadData: loadDataSubject.asObserver())
        
        self.networkManager = NetworkManager()
        self.disposeBag = DisposeBag()
        
        self.loadTrendMovieData(subject: loadDataSubject)
    }
    
    private let networkManager: NetworkManager
    private let disposeBag: DisposeBag
    
    // 파라미터로 던지기
    private func loadTrendMovieData(subject: PublishSubject<MakeURL.SubPath>) {
        
        subject.flatMap { subPath in
            let url = MakeURL.trendMovie(subPath).url
            let parameters = TMDBQueryParameters(
                language: self.getLangauge, key: self.getAPIKEY(type: .TMDB)
            )
            return self.networkManager.loadAPIData(url: url, parameters: parameters) as Single<TMDBTrendMovieList>
        }.subscribe { (response: TMDBTrendMovieList) in
            let trendMovieList = response.trendMovieItems.map { movieItem in
                TrendMovie(movieCode: movieItem.movieID,
                           posterImage: movieItem.movieImageURL,
                           posterName: movieItem.movieKoreaTitle
                )
            }
            self.state.trendMovieList.onNext(trendMovieList)
        }.disposed(by: self.disposeBag)
    }
}

//MARK: - Use at TMDB
/*
extension HomeViewModel {
    
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
*/
