//
//  HomeHeaderView.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

final class HomeHeaderView: UICollectionReusableView, ReusableCell {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Private Property
    
    private let sortStack: UIStackView = {
       let sortStack = UIStackView()
        sortStack.axis = .horizontal
        sortStack.alignment = .leading
        sortStack.spacing = MagicNumber.Attributes.spcing
        sortStack.distribution = .fillEqually
        return sortStack
    }()
    
    private let trendTitle: UILabel = {
        let trendTitle = UILabel()
        trendTitle.text = MagicLiteral.Title.title
        trendTitle.font = .boldSystemFont(ofSize: 24)
        trendTitle.textColor = .white
        return trendTitle
    }()
    
    private lazy var sortedByTrendDay: UIButton = {
        let sortedByTrendDay = UIButton()
        
        sortedByTrendDay.layer.borderWidth = MagicNumber.borderWidth
        sortedByTrendDay.layer.cornerRadius = MagicNumber.cornerRadius
        sortedByTrendDay.layer.borderColor = UIColor.systemGray5.cgColor
        
        sortedByTrendDay.setTitle(MagicLiteral.Title.todayTrendList, for: .normal)
        sortedByTrendDay.titleLabel?.font = .boldSystemFont(
            ofSize: MagicNumber.Attributes.fontSize
        )
        
        sortedByTrendDay.setTitleColor(.systemMint, for: .normal)
        sortedByTrendDay.backgroundColor = .systemIndigo
        
        return sortedByTrendDay
    }()
    
    private lazy var sortedByTrendWeek: UIButton = {
        let sortedByTrendWeek = UIButton()
        
        sortedByTrendWeek.layer.borderWidth = MagicNumber.borderWidth
        sortedByTrendWeek.layer.cornerRadius = MagicNumber.cornerRadius
        sortedByTrendWeek.layer.borderColor = UIColor.systemGray5.cgColor
        
        sortedByTrendWeek.setTitle(MagicLiteral.Title.weekTrendList, for: .normal)
        sortedByTrendWeek.titleLabel?.font = .boldSystemFont(
            ofSize: MagicNumber.Attributes.fontSize
        )
        sortedByTrendWeek.setTitleColor(.systemMint, for: .normal)
        
        //TODO: - Button Configuration으로 변경하여 Edge 넣기 -> iOS 버전이 높아서 inset을 다른 방법으로 진행
        return sortedByTrendWeek
    }()
    
    private let stillCutTitle: UILabel = {
       let stillCutTitle = UILabel()
        
        stillCutTitle.text = MagicLiteral.Title.stillCut
        stillCutTitle.font = .boldSystemFont(
            ofSize: MagicNumber.Attributes.headerTitleFont
        )
        stillCutTitle.textColor = UIColor.white
        return stillCutTitle
    }()
    
    private let koreaMovieListTitle: UILabel = {
        let koreaMovieListTitle = UILabel()
        
        koreaMovieListTitle.text = MagicLiteral.Title.koreaBoxOfficeMovieList
        koreaMovieListTitle.font = .boldSystemFont(
            ofSize: MagicNumber.Attributes.headerTitleFont
        )
        koreaMovieListTitle.textColor = UIColor.white
        return koreaMovieListTitle
    }()
}

//MARK: - [Public Method] Configure of Button Action
extension HomeHeaderView {
    
    func selectedTrendWeekButton() async {
        sortedByTrendWeek.addTarget(
            self, action: #selector(selectSortedByTrendWeek),
            for: .touchUpInside
        )
    }
    
    func selectedTrendDayButton() async {
        sortedByTrendDay.addTarget(
            self, action: #selector(selectSortedByTrendDay),
            for: .touchUpInside
        )
    }
    
    @objc private func selectSortedByTrendWeek() {
        sortedByTrendDay.backgroundColor = .black
        sortedByTrendWeek.backgroundColor = .systemIndigo
        sortedByTrendWeek.setTitleColor(.systemMint, for: .normal)
    }
    
    @objc private func selectSortedByTrendDay() {
        sortedByTrendWeek.backgroundColor = .black
        sortedByTrendDay.backgroundColor = .systemIndigo
        sortedByTrendDay.setTitleColor(.systemMint, for: .normal)
    }
}

//MARK: - [Public Method] Configure of Layout
extension HomeHeaderView {
    
    func configureOfSortStackLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.addSubview(sortStack)
        sortStack.addArrangedSubview(trendTitle)
        sortStack.addArrangedSubview(sortedByTrendDay)
        sortStack.addArrangedSubview(sortedByTrendWeek)
        
        sortStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sortStack.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: 10
            ),
            sortStack.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 15
            ),
            sortStack.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
            sortStack.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.6
            )
        ])
    }
    
    func configureOfStillCutLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.addSubview(stillCutTitle)
        stillCutTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stillCutTitle.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            stillCutTitle.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 20
            ),
            stillCutTitle.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            stillCutTitle.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            )
        ])
    }
    
    func configureOfKoreaMovieLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.addSubview(koreaMovieListTitle)
        koreaMovieListTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            koreaMovieListTitle.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            koreaMovieListTitle.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 20
            ),
            koreaMovieListTitle.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            )
        ])
    }
}
