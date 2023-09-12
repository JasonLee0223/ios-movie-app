//
//  TrendMovieListCell.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

final class TrendMovieListCell: UICollectionViewCell, ConfigurableCell {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureOfLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureOfLayout()
    }
    
    //MARK: - Private Property
    
    private let posterStack: UIStackView = {
        let posterStack = UIStackView()
        posterStack.axis = .vertical
        posterStack.alignment = .fill
        posterStack.distribution = .fill
        return posterStack
    }()
    
    private let posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.contentMode = .scaleToFill
        posterImage.clipsToBounds = true
        posterImage.layer.cornerRadius = MagicNumber.cornerRadius
        return posterImage
    }()
    
    private let posterName: UILabel = {
       let posterName = UILabel()
        //TODO: - Noto Sans KR font로 변경
        posterName.font = .systemFont(
            ofSize: MagicNumber.Attributes.fontSize
        )
        posterName.textColor = .white
        return posterName
    }()
}

//MARK: - Public Method
extension TrendMovieListCell {
    
    func configure(_ item: TrendMovie, at indexPath: IndexPath) {
//        guard let movieImage = UIImage(data: item.posterImage) else {
//            return
//        }
        
        setPoster(with: item.posterName)
//        setPoster(with: movieImage)
    }
}

//MARK: - [Private Method] Configure of UI Components
extension TrendMovieListCell {
    
    private func setPoster(with image: UIImage) {
        posterImage.image = image
    }
    
    private func setPoster(with name: String) {
        posterName.text = name
    }
}

//MARK: - [Private Method] Configure of Layout
extension TrendMovieListCell {
    
    private func configureOfLayout() {
        let safeArea = self.contentView.safeAreaLayoutGuide
        self.contentView.addSubview(posterStack)
        posterStack.addArrangedSubview(posterImage)
        posterStack.addArrangedSubview(posterName)
        
        posterStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterStack.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            posterStack.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            posterStack.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            posterStack.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            )
        ])
        
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(
                equalTo: posterStack.topAnchor
            ),
            posterImage.leadingAnchor.constraint(
                equalTo: posterStack.leadingAnchor
            ),
            posterImage.trailingAnchor.constraint(
                equalTo: posterStack.trailingAnchor
            ),
            posterImage.bottomAnchor.constraint(
                equalTo: posterName.bottomAnchor,
                constant: MagicNumber.Cell.bottomAnchorConstraint
            )
        ])
    }
}
