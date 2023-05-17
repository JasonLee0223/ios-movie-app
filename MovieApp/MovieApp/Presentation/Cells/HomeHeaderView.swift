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
        self.addSubview(sortStack)
        sortStack.addArrangedSubview(sortedByMovieRelease)
        sortStack.addArrangedSubview(sortedByTicketing)
    }
    
    func configureOfGenreLayout() {
        self.addSubview(genreTitle)
    }
    
    //MARK: - Private Property
    
    private let sortStack: UIStackView = {
       let sortStack = UIStackView()
        sortStack.axis = .horizontal
        sortStack.alignment = .leading
        sortStack.spacing = MagicNumber.Attributes.spcing
        sortStack.distribution = .equalSpacing
        return sortStack
    }()
    
    private let sortedByMovieRelease: UIButton = {
        let sortedByMovieRelease = UIButton()
        
        sortedByMovieRelease.setTitle(MagicLiteral.Title.movieRealese,
                                      for: .normal)
        sortedByMovieRelease.titleLabel?.font = .boldSystemFont(ofSize: MagicNumber.Attributes.fontSize)
        sortedByMovieRelease.tintColor = .white
        
        //TODO: - push했을 때 pink 컬러로 변환되도록 설정
        sortedByMovieRelease.backgroundColor = .systemPink
        return sortedByMovieRelease
    }()

    private let sortedByTicketing: UIButton = {
        let sortedByTicketing = UIButton()
        sortedByTicketing.setTitle(MagicLiteral.Title.ticketing,
                                   for: .normal)
        sortedByTicketing.titleLabel?.font = .boldSystemFont(ofSize: MagicNumber.Attributes.fontSize)
        sortedByTicketing.tintColor = .white
        
        return sortedByTicketing
    }()
    
    private let genreTitle: UILabel = {
       let genreTitle = UILabel()
        
        genreTitle.text = MagicLiteral.Title.genre
        genreTitle.font = .boldSystemFont(ofSize: MagicNumber.Attributes.genreTitleFont)
        return genreTitle
    }()
}
