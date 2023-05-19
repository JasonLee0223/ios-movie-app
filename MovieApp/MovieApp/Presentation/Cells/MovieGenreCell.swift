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
        backgroundColor = .green
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
        self.contentView.addSubview(genreStack)
        genreStack.addArrangedSubview(genrePosterImage)
        genreStack.addArrangedSubview(genreTypeName)
        
        genreStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genreStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            genreStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            genreStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            genreStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])

        genrePosterImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genrePosterImage.topAnchor.constraint(equalTo: genreStack.topAnchor),
            genrePosterImage.leadingAnchor.constraint(equalTo: genreStack.leadingAnchor),
            genrePosterImage.trailingAnchor.constraint(equalTo: genreStack.trailingAnchor),
            genrePosterImage.bottomAnchor.constraint(equalTo: genreTypeName.bottomAnchor, constant: -26)
        ])
//
        genreTypeName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            genreTypeName.topAnchor.constraint(equalTo: genrePosterImage.bottomAnchor),
            genreTypeName.widthAnchor.constraint(equalTo: genrePosterImage.widthAnchor, multiplier: 1/2)
        ])
    }
    
    //MARK: - Private Property
    
    private let genreStack: UIStackView = {
        let genreStack = UIStackView()
        genreStack.axis = .vertical
        genreStack.alignment = .center
        genreStack.distribution = .fill
        return genreStack
    }()
    
    private let genrePosterImage: UIImageView = {
       let genrePosterImage = UIImageView()
        genrePosterImage.backgroundColor = .blue
        return genrePosterImage
    }()
    
    private let genreTypeName: UILabel = {
        let genreTypeName = UILabel()
        genreTypeName.backgroundColor = .brown
        genreTypeName.font = .systemFont(ofSize: MagicNumber.Attributes.fontSize)
        return genreTypeName
    }()
}
