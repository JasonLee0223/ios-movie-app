//
//  DetailEntityWrapper.swift
//  MovieApp
//
//  Created by Jason on 2023/05/31.
//

import Foundation

enum DetailEntityWrapper: Hashable {
    case movieDetailInformation(MovieInformation)
    case movieCast(MovieCast)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .movieDetailInformation(let item):
            hasher.combine(item)
            
        case .movieCast(let item):
            hasher.combine(item)
        }
    }
    
    static func ==(lhs: DetailEntityWrapper, rhs: DetailEntityWrapper) -> Bool {
        switch (lhs, rhs) {
        case (
            .movieDetailInformation(let lhsItem), .movieDetailInformation(let rhsItem)
        ): return lhsItem == rhsItem
            
        case (
            .movieCast(let lhsItem), .movieCast(let rhsItem)
        ): return lhsItem == rhsItem
        
        default:
            return false
        }
    }
}
