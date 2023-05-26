//
//  MovieStillCutCell.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

final class MovieStillCutCell: UICollectionViewCell, ConfigurableCell {
    
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
    func configure(_ item: StillCut, at indexPath: IndexPath) {
        let imageData = item.genreImagePath
        guard let image = UIImage(data: imageData) else { return }
        
        setGenrePoster(with: image)
    }
    
    func setGenrePoster(with image: UIImage) {
        stillCutImage.image = image
    }
    
    //MARK: - Private Method
    private func configureOfLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.contentView.addSubview(stillCutStack)
        stillCutStack.addArrangedSubview(stillCutImage)
        
        stillCutStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stillCutStack.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            stillCutStack.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            stillCutStack.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            stillCutStack.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            )
        ])

        stillCutImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stillCutImage.topAnchor.constraint(
                equalTo: stillCutStack.topAnchor
            ),
            stillCutImage.leadingAnchor.constraint(
                equalTo: stillCutStack.leadingAnchor
            ),
            stillCutImage.trailingAnchor.constraint(
                equalTo: stillCutStack.trailingAnchor
            ),
            stillCutImage.bottomAnchor.constraint(
                equalTo: stillCutStack.bottomAnchor
            )
        ])
    }
    
    //MARK: - Private Property
    
    private let stillCutStack: UIStackView = {
        let genreStack = UIStackView()
        genreStack.axis = .vertical
        genreStack.alignment = .center
        genreStack.distribution = .fill
        return genreStack
    }()
    
    private let stillCutImage: UIImageView = {
       let genrePosterImage = UIImageView()
        genrePosterImage.contentMode = .scaleToFill
        genrePosterImage.clipsToBounds = true
        genrePosterImage.layer.cornerRadius = MagicNumber.cornerRadius
        return genrePosterImage
    }()
}
