//
//  KoreaBoxOfficeListCell.swift
//  MovieApp
//
//  Created by Jason on 2023/05/22.
//

import UIKit

final class KoreaBoxOfficeListCell: UICollectionViewListCell, Convertible, Gettable {
    
    //MARK: - Property

    var rankView = RankView()
    var summaryInformationView = SummaryInformationView()
    
    //MARK: - Initializer

    override init(frame: CGRect) {
        super .init(frame: frame)
        configureOfAllUIComponents()
    }

    required init?(coder: NSCoder) {
        super .init(coder: coder)
        configureOfAllUIComponents()
    }
    
    func configureOfCellRegistration(with dailyBoxOffice: DailyBoxOffice) {
            
        let audienceCount = converter.convertToNumberFormatter(
            dailyBoxOffice.movieSummaryInformation.audienceCount,
            accumulated: dailyBoxOffice.movieSummaryInformation.audienceAccumulated
        )
        
        let rankVariation = selector.determineRankVariation(
            with: dailyBoxOffice.rank.rankVariation,
            and: dailyBoxOffice.rank.rankOldAndNew
        )
        
        let rankVariationColor = selector.determineRankVariationColor(
            with: dailyBoxOffice.rank.rankOldAndNew
        )
        
        let rankImage = selector.determineVariationImage(
            with: dailyBoxOffice.rank.rankVariation
        )
        
        let rankImageColor = selector.determineVariationImageColor(
            with: dailyBoxOffice.rank.rankVariation
        )
        
        summaryInformationView.setMovieName(
            by: dailyBoxOffice.movieSummaryInformation.movieName
        )
        summaryInformationView.setAudienceCount(
            by: audienceCount
        )
        
        rankView.setRankVariation(by: rankVariation)
        rankView.setRankVariation(by: rankVariationColor)
        
        if dailyBoxOffice.rank.rankOldAndNew == RankOldAndNew.new || dailyBoxOffice.rank.rankVariation == "0" {
            rankView.setRankImage(by: UIImage())
            rankView.setRankImage(by: .black)
        } else {
            rankView.setRankImage(by: rankImage)
            rankView.setRankImage(by: rankImageColor)
        }
        
        rankView.setRank(by: dailyBoxOffice.rank.rank)
        
        accessories = [.disclosureIndicator()]
    }
    
    private func configureOfAllUIComponents() {

        let contentStackView = UIStackView()
        contentStackView.axis = .horizontal
        contentStackView.alignment = .leading
        contentStackView.distribution = .fill
        contentStackView.backgroundColor = .black

        contentView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])

        contentStackView.addSubview(rankView)
        contentStackView.addSubview(summaryInformationView)

        rankView.translatesAutoresizingMaskIntoConstraints = false
        summaryInformationView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            rankView.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            rankView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            rankView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor),
            rankView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor,
                                            multiplier: MagicNumber.Cell.widthAnchorMultiplier),

            summaryInformationView.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            summaryInformationView.leadingAnchor.constraint(equalTo: rankView.trailingAnchor,
                                                            constant: MagicNumber.Cell.leadingAnchorConstraint),
            summaryInformationView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            summaryInformationView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor)
        ])
    }
    
    //MARK: - Private Property
    private let selector = Selector()
    private let converter = Converter()
}
