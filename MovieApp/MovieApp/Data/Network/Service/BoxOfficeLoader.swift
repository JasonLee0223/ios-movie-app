//
//  BoxOfficeLoader.swift
//  MovieApp
//
//  Created by Jason on 2023/08/11.
//

import Foundation

final class BoxOfficeLoader {
    
    //MARK: - Initializer
    
    init() {
        self.networkService = NetworkService()
    }
    
    private let networkService: NetworkService
}

extension BoxOfficeLoader {
    
    /// BoxOfficeMovieList
    
//    func loadDailyBoxOfficeMovieListData() async -> [DailyBoxOfficeList] {
//        let yesterdayDate = Getter.receiveCurrentDate.split(separator: "-").joined()
//        let boxOfficeQueryParameters = BoxOfficeQueryParameters(targetDate: yesterdayDate)
//
//        var networkResult = [DailyBoxOfficeList]()
//        do {
//            networkResult = try await networkService.request(
//                with: KOFICAPIEndPoint.receiveBoxOffice(
//                    with: boxOfficeQueryParameters)
//            ).boxOfficeResult.dailyBoxOfficeList
//        } catch {
//            print(DataLoadError.loadFailOfBoxOfficeList)
//        }
//
//        return networkResult
//    }
}
