//
//  SummaryInfromationView.swift
//  MovieApp
//
//  Created by Jason on 2023/05/22.
//

import UIKit

final class SummaryInformationView: UIStackView {
    
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
        alignment = .leading
        distribution = .fillEqually
    }
    
    private func configureOfComponents() {
        addArrangedSubview(movieName)
        addArrangedSubview(audienceCount)
    }
    
    //MARK: - Private Property

    private let movieName: UILabel = {
        let movieName = UILabel()
        movieName.font = .boldSystemFont(ofSize: MagicNumber.Attributes.fontSize)
        movieName.textColor = UIColor.white
        return movieName
    }()

    private let audienceCount: UILabel = {
        let audienceCount = UILabel()
        audienceCount.font = .systemFont(ofSize: MagicNumber.Attributes.fontSize)
        audienceCount.textColor = UIColor.white
        return audienceCount
    }()
}

//MARK: - Methods that define the attribute of UI components
extension SummaryInformationView {
    func setMovieName(by text: String) {
        movieName.text = text
    }
    
    func setAudienceCount(by text: String) {
        audienceCount.text = text
    }
}
