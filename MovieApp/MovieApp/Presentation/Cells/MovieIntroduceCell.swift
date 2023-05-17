//
//  MovieIntroduceCell.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

final class MovieIntroduceCell: UICollectionViewCell {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureOfLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureOfLayout()
    }
    
    //MARK: - Method
    func setPoster(with image: UIImage) {
        posterImage.image = image
    }
    
    func setPoster(with name: String) {
        posterName.text = name
    }
    
    //MARK: - Private Method
    
    private func configureOfLayout() {
        self.addSubview(posterStack)
        posterStack.addArrangedSubview(posterImage)
        posterStack.addArrangedSubview(posterName)
    }
    
    //MARK: - Private Property
    
    private let posterStack: UIStackView = {
        let posterStack = UIStackView()
        posterStack.axis = .vertical
        posterStack.alignment = .center
        posterStack.spacing = MagicLiteral.RelatedToMovieIntroduceCell.spcing
        posterStack.distribution = .equalSpacing
        return posterStack
    }()
    
    private let posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.layer.cornerRadius = MagicLiteral.RelatedToMovieIntroduceCell.posterImageCornerRadius
        return posterImage
    }()
    
    private let posterName: UILabel = {
       let posterName = UILabel()
        posterName.font = .systemFont(ofSize: MagicLiteral.RelatedToMovieIntroduceCell.posterTitleFont)
        return posterName
    }()
}
