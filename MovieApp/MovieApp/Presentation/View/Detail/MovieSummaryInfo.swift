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
    let mockData = ["전체 관람가", "슈퍼 마리오 브라더스",
                    "The Super Mario Bros", "2023.04.26",
                    "미국", "애니메이션", "92분"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
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
        movieKoreanName.textColor = .black
        movieKoreanName.sizeToFit()
        return movieKoreanName
    }()
    
    private let movieEnglishName: UILabel = {
        let movieEnglishName = UILabel()
        movieEnglishName.font = .systemFont(ofSize: 14)
        movieEnglishName.textColor = .black
        movieEnglishName.sizeToFit()
        return movieEnglishName
    }()
    
    private let screeningInformation: UILabel = {
        let screeningInformation = UILabel()
        screeningInformation.font = .systemFont(ofSize: 14)
        screeningInformation.textColor = .black
        screeningInformation.sizeToFit()
        return screeningInformation
    }()
}

//MARK: - Public Methdo
extension MovieSummaryInfo {
    func configureOfComponents(by textGroup: [String]) {
        setWatchGrade(by: textGroup[0])
        setMovieKoreanName(by: textGroup[1])
        setMovieEnglishName(by: textGroup[2])
        setScreeninigInformation(by: textGroup[3])
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
