//
//  Convertible.swift
//  MovieApp
//
//  Created by Jason on 2023/05/22.
//

import Foundation

protocol Convertible {
    func convertToNumberFormatter(_ audienceCount: String, accumulated: String) -> String
}

extension Convertible {
    
    func convertToNumberFormatter(_ audienceCount: String, accumulated: String) -> String {

        guard let audienceCount = Int(audienceCount), let audienceAccumulated = Int(accumulated) else {
            return ""
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        guard let audienceResult = numberFormatter.string(for: audienceCount),
                let audienceAccumulatedCount = numberFormatter.string(for: audienceAccumulated) else {
            return ""
        }

        return MagicLiteral.todayAudience + audienceResult + MagicLiteral.totalAudience + audienceAccumulatedCount
    }
}
