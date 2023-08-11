//
//  BoxOfficeViewModel.swift
//  MovieApp
//
//  Created by Jason on 2023/08/11.
//

import Foundation

final class BoxOfficeViewModel {
    
    init() {
        self.boxOfficeLoader = BoxOfficeLoader()
    }
    
    private let boxOfficeLoader: BoxOfficeLoader
}

//MARK: - [Public] Use at BoxOfficeViewController
extension BoxOfficeViewModel {
    
    func fetchBoxOfficeMovieList() async -> [KoreaBoxOfficeList] {
        var dailyBoxOfficeListGroup = [DailyBoxOfficeList]()
        
        dailyBoxOfficeListGroup = await boxOfficeLoader.loadDailyBoxOfficeMovieListData()
        
        let koreaBoxOfficeMovieListGroup = dailyBoxOfficeListGroup.map { dailyBoxOfficeList in
            KoreaBoxOfficeList(
                openDate: dailyBoxOfficeList.openDate,
                rank: Rank(
                    rank: dailyBoxOfficeList.rank,
                    rankOldAndNew: dailyBoxOfficeList.rankOldAndNew,
                    rankVariation: dailyBoxOfficeList.rankVariation
                ),
                movieSummaryInformation: MovieSummaryInformation(
                    movieName: dailyBoxOfficeList.movieName,
                    audienceCount: dailyBoxOfficeList.audienceCount,
                    audienceAccumulated: dailyBoxOfficeList.audienceAccumulate
                )
            )
        }
        
        return koreaBoxOfficeMovieListGroup
    }
}
