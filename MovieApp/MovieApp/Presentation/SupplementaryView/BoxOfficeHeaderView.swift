//
//  BoxOfficeHeaderView.swift
//  MovieApp
//
//  Created by Jason on 2023/08/11.
//

import UIKit

final class BoxOfficeHeaderView: UICollectionReusableView, ReusableCell {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Private Property
    
    private let boxOfficeHeaderTitle: UILabel = {
        let boxOfficeHeaderTitle = UILabel()
        
        boxOfficeHeaderTitle.text = MagicLiteral.Title.koreaBoxOfficeMovieList
        boxOfficeHeaderTitle.font = .boldSystemFont(
            ofSize: MagicNumber.Attributes.headerTitleFont
        )
        boxOfficeHeaderTitle.textColor = UIColor.white
        return boxOfficeHeaderTitle
    }()
}

//MARK: - Configure of HeaderView Layout
extension BoxOfficeHeaderView {
    
    func configureOfBoxOfficeLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.addSubview(boxOfficeHeaderTitle)
        boxOfficeHeaderTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            boxOfficeHeaderTitle.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            boxOfficeHeaderTitle.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 20
            ),
            boxOfficeHeaderTitle.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            )
        ])
    }
}
