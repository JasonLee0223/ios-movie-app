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
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sortStack.subviews.forEach { view in
            view.removeFromSuperview()
        }
        stillCutTitle.removeFromSuperview()
        koreaMovieListTitle.removeFromSuperview()
    }
    
    //MARK: - Private Property
    private let sortStack = UIStackView()
    private let sortedByTrendWeek = UIButton()
    private let sortedByTrendDay = UIButton()
    private let stillCutTitle = UILabel()
    private let koreaMovieListTitle = UILabel()
    
    private func setupAttributes() {
        sortStack.axis = .horizontal
        sortStack.alignment = .leading
        sortStack.spacing = MagicNumber.Attributes.spcing
        sortStack.distribution = .fillEqually
        
        sortedByTrendWeek.layer.cornerRadius = MagicNumber.cornerRadius
        sortedByTrendWeek.layer.borderWidth = MagicNumber.borderWidth
        sortedByTrendWeek.layer.borderColor = UIColor.systemGray5.cgColor
        sortedByTrendWeek.setTitle(MagicLiteral.Title.weekTrendList,
                                      for: .normal)
        sortedByTrendWeek.titleLabel?.font = .boldSystemFont(
            ofSize: MagicNumber.Attributes.fontSize
        )
        sortedByTrendWeek.tintColor = .white
        sortedByTrendWeek.backgroundColor = .systemPink
        
        sortedByTrendDay.layer.borderColor = UIColor.systemGray5.cgColor
        sortedByTrendDay.layer.borderWidth = MagicNumber.borderWidth
        sortedByTrendDay.layer.cornerRadius = MagicNumber.cornerRadius
        
        sortedByTrendDay.setTitle(
            MagicLiteral.Title.todayTrendList,
            for: .normal
        )
        sortedByTrendDay.titleLabel?.font = .boldSystemFont(
            ofSize: MagicNumber.Attributes.fontSize
        )
        sortedByTrendDay.tintColor = UIColor.white
        
        stillCutTitle.text = MagicLiteral.Title.stillCut
        stillCutTitle.font = .boldSystemFont(
            ofSize: MagicNumber.Attributes.headerTitleFont
        )
        stillCutTitle.textColor = UIColor.white
        
        koreaMovieListTitle.text = MagicLiteral.Title.koreaBoxOfficeMovieList
        koreaMovieListTitle.font = .boldSystemFont(
            ofSize: MagicNumber.Attributes.headerTitleFont
        )
        koreaMovieListTitle.textColor = UIColor.white
    }
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
        sortedByTrendWeek.backgroundColor = .systemPink
        sortedByTrendDay.backgroundColor = .black
    }
    
    @objc private func selectSortedByTrendDay() {
        sortedByTrendWeek.backgroundColor = .black
        sortedByTrendDay.backgroundColor = .systemPink
    }
}

//MARK: - [Public Method] Configure of Layout
extension HomeHeaderView {
    
    func configureOfSortStackLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.addSubview(sortStack)
        sortStack.addArrangedSubview(sortedByTrendWeek)
        sortStack.addArrangedSubview(sortedByTrendDay)
        
        sortStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sortStack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            sortStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            sortStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            sortStack.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.75)
        ])
    }
    
    func configureOfStillCutLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.addSubview(stillCutTitle)
        stillCutTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stillCutTitle.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stillCutTitle.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            stillCutTitle.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stillCutTitle.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func configureOfKoreaMovieLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.addSubview(koreaMovieListTitle)
        koreaMovieListTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            koreaMovieListTitle.topAnchor.constraint(equalTo: safeArea.topAnchor),
            koreaMovieListTitle.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            koreaMovieListTitle.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
