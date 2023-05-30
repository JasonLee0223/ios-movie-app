//
//  DetailHeaderView.swift
//  MovieApp
//
//  Created by Jason on 2023/05/28.
//

import UIKit

final class DetailHeaderView: UICollectionReusableView, ReusableCell {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let movieOfficialsTitle: UILabel = {
        let movieOfficialsTitle = UILabel()
        
        movieOfficialsTitle.text = MagicLiteral.Title.movieOfficials
        movieOfficialsTitle.font = .boldSystemFont(
            ofSize: MagicNumber.Attributes.headerTitleFont
        )
        movieOfficialsTitle.textColor = UIColor.white
        return movieOfficialsTitle
    }()
    
    private let audienceCountTitle: UILabel = {
        let audienceCountTitle = UILabel()
        
        audienceCountTitle.text = MagicLiteral.Title.audienceCount
        audienceCountTitle.font = .boldSystemFont(
            ofSize: MagicNumber.Attributes.headerTitleFont
        )
        audienceCountTitle.textColor = UIColor.white
        return audienceCountTitle
    }()
}

//MARK: - [Public Method] Configure of Layout
extension DetailHeaderView {
    
    /// Section 2
    func configureOfMovieOfficialsLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.addSubview(movieOfficialsTitle)
        movieOfficialsTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieOfficialsTitle.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            movieOfficialsTitle.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 20
            ),
            movieOfficialsTitle.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            movieOfficialsTitle.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            )
        ])
    }
    
    /// Section 3
    func configureOfaudienceCountLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.addSubview(audienceCountTitle)
        audienceCountTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            audienceCountTitle.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            audienceCountTitle.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 20
            ),
            audienceCountTitle.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            )
        ])
    }
}
