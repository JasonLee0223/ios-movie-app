//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Jason on 2023/09/05.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager: Gettable {
    
    
    /// TMDB
    func loadTrendMovieList(path: MakeQueryItem.SubPath) -> Single<[Result]> {
        
        let url = MakeQueryItem.trendMovie(path).url
        let parameters = TMDBQueryParameters(language: getLangauge, key: getAPIKEY(type: .TMDB))
        
        return Single<[Result]>.create { single in
            AF.request(url, method: .get, parameters: parameters)
                .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try self.decoder.decode(TMDBTrendMovieList.self, from: data)
                        single(.success(result.results))
                    } catch {
                        print(DataLoadError.loadFailOfTrendMovieListData)
                    }
                case .failure(let error):
                    print(error)
                    break
                }
            }
            return Disposables.create()
        }
    }
    
    func loadMovieDetailInformation(movieCode: String, completionHandler: @escaping (TMDBMovieDetail) -> Void) {
        
        let urlArray = [MakeQueryItem.detail(movieCode).url, MakeQueryItem.credit(movieCode, .credit).url]
        let group = DispatchGroup()
        
        urlArray.forEach { url in
            
            let parameters = TMDBQueryParameters(language: getLangauge, key: getAPIKEY(type: .TMDB))
            
            AF.request(url, method: .get, parameters: parameters)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let result = try self.decoder.decode(TMDBMovieDetail.self, from: data)
                            completionHandler(result)
                        } catch {
                            print(DataLoadError.loadFailOfMovieDetailInfromationData)
                        }
                    case .failure(let error):
                        print(error)
                        break
                    }
                }
            group.leave()
        }
        
        group.notify(queue: .global()) {
            print("All Request Completed")
        }
    }
    
    /// BoxOffice
    func loadBoxOffice() -> Single<[DailyBoxOfficeList]> {
        let url = MakeQueryItem.boxOffice.url
        let parameters = BoxOfficeQueryParameters(
            key: getAPIKEY(type: .KOFIC),
            targetDate: getCurrentDate().split(separator: "-").joined()
        )
        
        return Single<[DailyBoxOfficeList]>.create { single in
            AF.request(url, method: .get, parameters: parameters)
                .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try self.decoder.decode(BoxOffice.self, from: data)
                        single(.success(result.boxOfficeResult.dailyBoxOfficeList))
                    } catch {
                        print(DataLoadError.loadFailOfBoxOfficeList)
                    }
                case .failure(let error):
                    print(error)
                    break
                }
            }
            return Disposables.create()
        }
    }
    
    private let decoder = JSONDecoder()
}
