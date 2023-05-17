//
//  MovieGenreCell.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

final class MovieGenreCell: UICollectionViewCell, Gettable {
    
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
    func setGenrePoster(with image: UIImage) {
        genrePosterImage.image = image
    }
    
    func setGenreType(with name: String) {
        genreTypeName.text = name
    }
    
    //MARK: - Private Method
    private func configureOfLayout() {
        self.addSubview(genreStack)
        genreStack.addArrangedSubview(genrePosterImage)
        genreStack.addArrangedSubview(genreTypeName)
    }
    
    //MARK: - Private Property
    
    private let genreStack: UIStackView = {
        let genreStack = UIStackView()
        genreStack.axis = .vertical
        genreStack.alignment = .center
        genreStack.spacing = MagicNumber.Attributes.spcing
        genreStack.distribution = .equalSpacing
        return genreStack
    }()
    
    private let genrePosterImage: UIImageView = {
       let genrePosterImage = UIImageView()
        genrePosterImage.frame = CGRect(origin: CGPoint(x: MagicNumber.zero,
                                                        y: MagicNumber.zero),
                                        size: CGSize(width: MagicNumber.Size.genrePosterWidth,
                                                     height: MagicNumber.Size.genrePosterHeight))
        genrePosterImage.layer.cornerRadius = MagicNumber.Attributes.imageCornerRadius
        return genrePosterImage
    }()
    
    private let genreTypeName: UILabel = {
        let genreTypeName = UILabel()
        genreTypeName.font = .systemFont(ofSize: MagicNumber.Attributes.fontSize)
        return genreTypeName
    }()
}
