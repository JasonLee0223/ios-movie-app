//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Jason on 2023/09/05.
//

import Foundation
import Alamofire

final class NetworkManager: Gettable {

    /// TMDB
    func loadTrendMovieList(path: MakeQueryItem.SubPath , completionHandler: @escaping ([Result]) -> Void) {
        
        let url = MakeQueryItem.trendMovie(path).url
        let parameters = TMDBQueryParameters(language: getLangauge, key: getAPIKEY(type: .TMDB))
        
        AF.request(url, method: .get, parameters: parameters)
            .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(TMDBTrendMovieList.self, from: data)
                    completionHandler(result.results)
                } catch {
                    print(DataLoadError.loadFailOfTrendMovieListData)
                }
            case .failure(let error):
                switch error {
                case .sessionTaskFailed(let sessionError):
                    print("Session Error: \(sessionError)")
                case .createURLRequestFailed(let urlRequestError):
                    print("URLRequest Error: \(urlRequestError)")
                default:
                    print(error)
                }
            }
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
                            //TODO: - Detail, Credit 어떤 타입인지 체크하는 로직으로 변경
                            let result = try JSONDecoder().decode(TMDBMovieDetail.self, from: data)
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
    func loadBoxOffice(completionHandler: @escaping ([DailyBoxOfficeList]) -> Void) {
        let url = MakeQueryItem.boxOffice.url
        let parameters = BoxOfficeQueryParameters(key: getAPIKEY(type: .KOFIC), targetDate: getCurrentDate().split(separator: "-").joined())
        
        AF.request(url, method: .get, parameters: parameters)
            .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(BoxOffice.self, from: data)
                    completionHandler(result.boxOfficeResult.dailyBoxOfficeList)
                } catch {
                    print(DataLoadError.loadFailOfBoxOfficeList)
                }
            case .failure(let error):
                switch error {
                case .sessionTaskFailed(let sessionError):
                    print("Session Error: \(sessionError)")
                case .createURLRequestFailed(let urlRequestError):
                    print("URLRequest Error: \(urlRequestError)")
                default:
                    print(error)
                }
            }
        }
    }
}
