//
//  RankView.swift
//  MovieApp
//
//  Created by Jason on 2023/05/22.
//

import UIKit

final class RankView: UIStackView {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureOfStackView()
        configureOfComponents()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureOfStackView()
        configureOfComponents()
    }

    //MARK: - Private Method
    
    private func configureOfStackView() {
        axis = .vertical
        spacing = 3
        alignment = .center
        distribution = .equalSpacing

        information.axis = .horizontal
        information.alignment = .center
        information.distribution = .equalSpacing
    }

    private func configureOfComponents() {
        addArrangedSubview(rank)
        addArrangedSubview(information)
        information.addArrangedSubview(rankEmoji)
        information.addArrangedSubview(rankVariation)
    }
    
    //MARK: - Private Property

    private var information: UIStackView = {
        let information = UIStackView()
        return information
    }()

    private let rank: UILabel = {
        let rankLabel = UILabel()
        rankLabel.font = .boldSystemFont(ofSize: MagicNumber.Attributes.fontSize)
        rankLabel.textColor = .white
        return rankLabel
    }()

    private let rankEmoji: UIImageView = {
        let rankEmoji = UIImageView()
        return rankEmoji
    }()

    private let rankVariation: UILabel = {
        let rankVariationLabel = UILabel()
        rankVariationLabel.font = .systemFont(ofSize: MagicNumber.Attributes.fontSize)
        rankVariationLabel.textColor = UIColor.white
        return rankVariationLabel
    }()
}

//MARK: - Methods that define the attribute of UI components
extension RankView {

    func setRank(by text: String) {
        rank.text = text
    }

    func setRankVariation(by text: String) {
        guard text != "-", let convertedText = Int(text) else {
            rankVariation.text = text
            return
        }

        rankVariation.text = String(describing: abs(convertedText))
    }

    func setRankVariation(by color: UIColor) {
        rankVariation.textColor = color
    }

    func setRankImage(by emoji: UIImage?) {
        rankEmoji.image = emoji
    }

    func setRankImage(by color: UIColor?) {
        rankEmoji.tintColor = color
    }
}
