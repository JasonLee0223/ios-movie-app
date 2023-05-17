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
        sortStack.alignment = .firstBaseline
        sortStack.spacing = MagicLiteral.RelatedToHeaderView.buttonSpcing
        sortStack.distribution = .equalSpacing
        return sortStack
    }()
    
    private let sortedByMovieRelease: UIButton = {
        let sortedByMovieRelease = UIButton()
        
        sortedByMovieRelease.setTitle(MagicLiteral.RelatedToHeaderView.movieRealeseTitle,
                                      for: .normal)
        sortedByMovieRelease.titleLabel?.font = .boldSystemFont(ofSize: MagicLiteral.RelatedToHeaderView.sortOfTypeFont)
        sortedByMovieRelease.tintColor = .white
        
        //TODO: - push했을 때 pink 컬러로 변환되도록 설정
        sortedByMovieRelease.backgroundColor = .systemPink
        return sortedByMovieRelease
    }()

    private let sortedByTicketing: UIButton = {
        let sortedByTicketing = UIButton()
        sortedByTicketing.setTitle(MagicLiteral.RelatedToHeaderView.ticketingTitle,
                                   for: .normal)
        sortedByTicketing.titleLabel?.font = .boldSystemFont(ofSize: MagicLiteral.RelatedToHeaderView.sortOfTypeFont)
        sortedByTicketing.tintColor = .white
        
        return sortedByTicketing
    }()
    
    private let genreTitle: UILabel = {
       let genreTitle = UILabel()
        
        genreTitle.text = MagicLiteral.RelatedToHeaderView.genreTitle
        genreTitle.font = .boldSystemFont(ofSize: MagicLiteral.RelatedToHeaderView.genreTitleFont)
        return genreTitle
    }()
}
