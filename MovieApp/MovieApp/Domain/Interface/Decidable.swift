//
//  Decidable.swift
//  MovieApp
//
//  Created by Jason on 2023/05/22.
//

import UIKit

protocol Decidable {
    func determineRankVariation(with rankVariation: String, and rankOldAndNew: RankOldAndNew) -> String
    func determineRankVariationColor(with rankOldAndNew: RankOldAndNew) -> UIColor
    func determineVariationImage(with rankVariation: String) -> UIImage
    func determineVariationImageColor(with rankVariation: String) -> UIColor
}

extension Decidable {
    func determineRankVariation(with rankVariation: String, and rankOldAndNew: RankOldAndNew) -> String {

        let returnValue = "-"

        switch rankOldAndNew {
        case .new:
            return MagicLiteral.newMovie
        case .old :
            guard rankVariation == MagicLiteral.zero else {
                return rankVariation
            }
            return returnValue
        }
    }

    func determineRankVariationColor(with rankOldAndNew: RankOldAndNew) -> UIColor {

        switch rankOldAndNew {
        case .new:
            return UIColor.red
        case .old:
            return UIColor.black
        }
    }

    func determineVariationImage(with rankVariation: String) -> UIImage {

        guard rankVariation.hasPrefix("-") else {
            return UIImage(systemName: MagicLiteral.upTriangle) ?? UIImage()
        }
        return UIImage(systemName: MagicLiteral.downTriangle) ?? UIImage()
    }

    func determineVariationImageColor(with rankVariation: String) -> UIColor {

        guard rankVariation.hasPrefix("-") else {
            return UIColor.red
        }
        return UIColor.blue
    }
}

