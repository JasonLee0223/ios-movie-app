//
//  HomeHeaderView.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

final class HomeHeaderView: UICollectionReusableView, Gettable {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray3
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .systemGray3
    }
    
    //MARK: - Method
    func configureOfSortStackLayout() {
        self.addSubview(sortStack)
        sortStack.addArrangedSubview(sortedByMovieRelease)
        sortStack.addArrangedSubview(sortedByTicketing)
        
        sortStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sortStack.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            sortStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            sortStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    func configureOfGenreLayout() {
        self.addSubview(genreTitle)
        genreTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genreTitle.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            genreTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 38),
            genreTitle.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
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
    
    private let sortedByMovieRelease: UIButton = {
        let sortedByMovieRelease = UIButton()
        
        sortedByMovieRelease.layer.cornerRadius = 10
        sortedByMovieRelease.setTitle(MagicLiteral.Title.movieRealese,
                                      for: .normal)
        sortedByMovieRelease.titleLabel?.font = .boldSystemFont(ofSize: MagicNumber.Attributes.fontSize)
        sortedByMovieRelease.tintColor = .white
        
        //TODO: - push했을 때 pink 컬러로 변환되도록 설정
        sortedByMovieRelease.backgroundColor = .systemPink
        
        //TODO: - Button Configuration으로 변경하여 Edge 넣기
        return sortedByMovieRelease
    }()

    private let sortedByTicketing: UIButton = {
        let sortedByTicketing = UIButton()
        
        sortedByTicketing.layer.cornerRadius = 10
        sortedByTicketing.setTitle(MagicLiteral.Title.ticketing,
                                   for: .normal)
        sortedByTicketing.titleLabel?.font = .boldSystemFont(ofSize: MagicNumber.Attributes.fontSize)
        sortedByTicketing.tintColor = .white
        sortedByTicketing.backgroundColor = .systemPink
        return sortedByTicketing
    }()
    
    private let genreTitle: UILabel = {
       let genreTitle = UILabel()
        
        genreTitle.text = MagicLiteral.Title.genre
        genreTitle.font = .boldSystemFont(ofSize: MagicNumber.Attributes.genreTitleFont)
        genreTitle.backgroundColor = .yellow
        return genreTitle
    }()
}
