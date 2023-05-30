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
        sortedByTicketing.layer.borderWidth = MagicNumber.borderWidth
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

//MARK: - [Public Method] Configure of Layout
extension HomeHeaderView {
    
    func configureOfSortStackLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.addSubview(sortStack)
        sortStack.addArrangedSubview(sortedByMovieRelease)
        sortStack.addArrangedSubview(sortedByTicketing)
        
        sortStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sortStack.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            sortStack.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 20
            ),
//            sortStack.trailingAnchor.constraint(
//                equalTo: safeArea.trailingAnchor
//            ),
            sortStack.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
            sortStack.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.5
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
