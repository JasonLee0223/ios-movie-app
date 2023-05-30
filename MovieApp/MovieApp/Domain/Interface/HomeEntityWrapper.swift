//
//  HomeEntityWrapper.swift
//  MovieApp
//
//  Created by Jason on 2023/05/25.
//

import Foundation

enum HomeEntityWrapper: Hashable {
    case trendMovie(TrendMovie)
    case stillCut(StillCut)
    case koreaBoxOfficeList(KoreaBoxOfficeList)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .trendMovie(let item):
            hasher.combine(item)
            
        case .stillCut(let item):
            hasher.combine(item)
            
        case .koreaBoxOfficeList(let item):
            hasher.combine(item)
        }
    }
    
    static func ==(lhs: HomeEntityWrapper, rhs: HomeEntityWrapper) -> Bool {
        switch (lhs, rhs) {
        case (
            .trendMovie(let lhsItem), .trendMovie(let rhsItem)
        ): return lhsItem == rhsItem
            
        case (
            .stillCut(let lhsItem), .stillCut(let rhsItem)
        ): return lhsItem == rhsItem
            
        case (
            .koreaBoxOfficeList(let lhsItem), .koreaBoxOfficeList(let rhsItem)
        ): return lhsItem == rhsItem
        
        default:
            return false
        }
    }
}
