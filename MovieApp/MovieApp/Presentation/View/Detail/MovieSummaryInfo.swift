//
//  MovieSummaryInfo.swift
//  MovieApp
//
//  Created by Jason on 2023/05/28.
//

import UIKit

//MARK: - [SubView] MovieSummaryInfo
final class MovieSummaryInfo: UIStackView {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureOfStackView()
        configureOfLayout()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureOfStackView()
        configureOfLayout()
    }
    
    //MARK: - Private Property

    private let watchGrade: UILabel = {
        let watchGrade = UILabel()
        watchGrade.font = .systemFont(ofSize: 15)
        watchGrade.textColor = .green
        watchGrade.layer.borderWidth = 1
        watchGrade.layer.borderColor = UIColor.green.cgColor
        watchGrade.layer.cornerRadius = 5
        watchGrade.sizeToFit()
        return watchGrade
    }()
    
    private let movieKoreanName: UILabel = {
        let movieKoreanName = UILabel()
        movieKoreanName.font = .boldSystemFont(ofSize: 26)
        movieKoreanName.textColor = .white
        movieKoreanName.sizeToFit()
        return movieKoreanName
    }()
    
    private let movieEnglishName: UILabel = {
        let movieEnglishName = UILabel()
        movieEnglishName.font = .systemFont(ofSize: 14)
        movieEnglishName.textColor = .white
        movieEnglishName.sizeToFit()
        return movieEnglishName
    }()
    
    private let screeningInformation: UILabel = {
        let screeningInformation = UILabel()
        screeningInformation.font = .systemFont(ofSize: 14)
        screeningInformation.textColor = .white
        screeningInformation.numberOfLines = 2
        screeningInformation.sizeToFit()
        return screeningInformation
    }()
}

//MARK: - Public Methdo
extension MovieSummaryInfo {
    
    func configureOfComponents(by textGroup: PosterHeaderArea, summary: String) {
        setWatchGrade(by: textGroup.watchGrade)
        setMovieKoreanName(by: textGroup.movieKoreanName)
        setMovieEnglishName(by: textGroup.movieEnglishName)
        setScreeninigInformation(by: summary)
    }
}

//MARK: - Private Method
extension MovieSummaryInfo {
    
    private func configureOfLayout() {
        self.addArrangedSubview(watchGrade)
        self.addArrangedSubview(movieKoreanName)
        self.addArrangedSubview(movieEnglishName)
        self.addArrangedSubview(screeningInformation)
    }
    
    private func configureOfStackView() {
        axis = .vertical
        alignment = .leading
        distribution = .fillEqually
    }
    
    private func setWatchGrade(by text: String) {
        watchGrade.text = text
    }
    
    private func setMovieKoreanName(by text: String) {
        movieKoreanName.text = text
    }
    
    private func setMovieEnglishName(by text: String) {
        movieEnglishName.text = text
    }
    
    private func setScreeninigInformation(by text: String) {
        screeningInformation.text = text
    }
}
