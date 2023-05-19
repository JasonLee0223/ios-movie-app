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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Method
    func configureOfSortStackLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.addSubview(sortStack)
        sortStack.addArrangedSubview(sortedByMovieRelease)
        sortStack.addArrangedSubview(sortedByTicketing)
        
        sortStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sortStack.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            ),
            sortStack.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: MagicNumber.HeaderView.sortStackTopAnchorConstraint
            ),
            sortStack.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: MagicNumber.HeaderView.leadingConstraint
            )
        ])
    }
    
    func configureOfGenreLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.addSubview(genreTitle)
        genreTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genreTitle.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            ),
            genreTitle.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: MagicNumber.HeaderView.genreTitleTopAnchorConstraint
            ),
            genreTitle.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: MagicNumber.HeaderView.leadingConstraint
            )
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
        
        sortedByMovieRelease.layer.cornerRadius = MagicNumber.cornerRadius
        sortedByMovieRelease.setTitle(MagicLiteral.Title.movieRealese,
                                      for: .normal)
        sortedByMovieRelease.titleLabel?.font = .boldSystemFont(
            ofSize: MagicNumber.Attributes.fontSize
        )
        sortedByMovieRelease.tintColor = .white
        
        //TODO: - push했을 때 pink 컬러로 변환되도록 설정
        sortedByMovieRelease.backgroundColor = .systemPink
        
        //TODO: - Button Configuration으로 변경하여 Edge 넣기
        return sortedByMovieRelease
    }()

    private let sortedByTicketing: UIButton = {
        let sortedByTicketing = UIButton()
        
        sortedByTicketing.layer.borderColor = UIColor.systemGray5.cgColor
        sortedByTicketing.layer.borderWidth = 0.5
        sortedByTicketing.layer.cornerRadius = MagicNumber.cornerRadius
        sortedByTicketing.setTitle(
            MagicLiteral.Title.ticketing,
            for: .normal
        )
        sortedByTicketing.titleLabel?.font = .boldSystemFont(
            ofSize: MagicNumber.Attributes.fontSize
        )
        sortedByTicketing.tintColor = UIColor.white
        return sortedByTicketing
    }()
    
    private let genreTitle: UILabel = {
       let genreTitle = UILabel()
        
        genreTitle.text = MagicLiteral.Title.genre
        genreTitle.font = .boldSystemFont(
            ofSize: MagicNumber.Attributes.genreTitleFont
        )
        genreTitle.textColor = UIColor.white
        return genreTitle
    }()
}
