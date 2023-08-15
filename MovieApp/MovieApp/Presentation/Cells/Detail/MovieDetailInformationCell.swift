//
//  MovieDetailInformationCell.swift
//  MovieApp
//
//  Created by Jason on 2023/05/28.
//

import UIKit

final class MovieDetailInformationCell: UICollectionViewCell, ReusableCell {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureOfLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureMoviePosterImageView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !seeMore.isHidden {
            seeMore.isHidden = true
        } else {
            seeMore.isHidden = false
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureOfLayout()
    }
    
    //MARK: - Private Property
    
    private let movieSummaryInfo = MovieSummaryInfo()
    
    private let posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.image = UIImage(systemName: "Suzume")
        posterImage.contentMode = .scaleToFill
        posterImage.clipsToBounds = true
        return posterImage
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        let colors: [CGColor] = [
            .init(gray: 0.0, alpha: 0.5),
            .init(gray: 0.0, alpha: 1)
        ]
        layer.locations = [0.25, 0.7]
        layer.colors = colors
        
        return layer
    }()
    
    private let movieDescription: UIStackView = {
        let movieDescription = UIStackView()
        movieDescription.axis = .vertical
        movieDescription.spacing = 16
        movieDescription.alignment = .leading
        movieDescription.distribution = .fillEqually
        return movieDescription
    }()
    
    private let overView: UILabel = {
        let overView = UILabel()
        overView.numberOfLines = 0
        overView.textAlignment = .left
        return overView
    }()
    
    private let seeMore: UIButton = {
        let seeMore = UIButton()
        seeMore.setTitle("더보기 ↓", for: .normal)
        seeMore.tintColor = .systemGray5
        seeMore.backgroundColor = .darkGray
        seeMore.layer.cornerRadius = 10
        seeMore.layer.borderWidth = 1
        seeMore.isHidden = false
        return seeMore
    }()
}

//MARK: - [Public Method] Configure of UI Components
extension MovieDetailInformationCell {
    func configure(_ item: MovieInformation,
                   at indexPath: IndexPath, posterImageData: Data
    ) {
        var nationSentence: String = ""
        var genreSentence: String = ""
        
        if item.nations.count == 1 {
            nationSentence = item.nations.first ?? ""
        } else {
            for nation in item.nations {
                let plusComma = nation + ", "
                nationSentence += plusComma
            }
        }
        
        for genre in item.genres {
            let plusComma = genre + ", "
            genreSentence += plusComma
        }
        
        let summary = "\(item.subInformation.releaseDate) | \(nationSentence) |\n \(genreSentence) | \(item.subInformation.runtime)"
        
        setPosterImage(by: posterImageData)
        
        movieSummaryInfo.configureOfComponents(by: item.posterHeaderArea, summary: summary)
        
        setOverView(by: item.subInformation.overview)
    }
}

//MARK: - [Private Method] Configure of UIComponents
extension MovieDetailInformationCell {
    
    private func configureMoviePosterImageView() {
        gradientLayer.frame = posterImage.bounds
    }
    
    private func setPosterImage(by data: Data) {
        guard let image = UIImage(data: data) else {
            return
        }
        posterImage.image = image
    }
    
    private func setOverView(by text: String) {
        
        let attributedString = NSMutableAttributedString(string: text)
        let length = attributedString.length
        attributedString.addAttributes(
            [.foregroundColor:UIColor.white,
             .font:UIFont.systemFont(ofSize: 16, weight: .bold)
            ],
            range: NSRange(location: 0, length: length)
        )
        overView.attributedText = attributedString
        overView.text = text
    }
}

//MARK: - [Private Method] Configure of Layout
extension MovieDetailInformationCell {
    
    private func configureOfLayout() {
        
        let safeArea = self.contentView.safeAreaLayoutGuide
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(posterImage)
        
        posterImage.layer.addSublayer(gradientLayer)
        self.contentView.addSubview(movieSummaryInfo)
        
        self.contentView.addSubview(movieDescription)
        movieDescription.addArrangedSubview(overView)
        movieDescription.addArrangedSubview(seeMore)
        
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(
                equalTo: topAnchor
            ),
            posterImage.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            posterImage.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            posterImage.heightAnchor.constraint(
                equalTo: heightAnchor
            )
        ])
        
        movieSummaryInfo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieSummaryInfo.leadingAnchor.constraint(
                equalTo: posterImage.leadingAnchor,
                constant: 20
            ),
            movieSummaryInfo.trailingAnchor.constraint(
                equalTo: posterImage.trailingAnchor,
                constant: -20
            ),
            movieSummaryInfo.centerYAnchor.constraint(
                equalTo: posterImage.centerYAnchor,
                constant: 40
            ),
            movieSummaryInfo.heightAnchor.constraint(
                equalTo: posterImage.heightAnchor, multiplier: 1 / 5
            )
        ])
        
        movieDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieDescription.topAnchor.constraint(
                equalTo: movieSummaryInfo.bottomAnchor,
                constant: 30
            ),
            movieDescription.leadingAnchor.constraint(
                equalTo: movieSummaryInfo.leadingAnchor
            ),
            movieDescription.trailingAnchor.constraint(
                equalTo: movieSummaryInfo.trailingAnchor
            ),
            movieDescription.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
            movieDescription.heightAnchor.constraint(
                equalTo: movieSummaryInfo.heightAnchor
            )
        ])
        
        seeMore.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieDescription.leadingAnchor.constraint(
                equalTo: seeMore.leadingAnchor
            ),
            movieDescription.trailingAnchor.constraint(
                equalTo: seeMore .trailingAnchor
            ),
            movieDescription.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
        ])
        
    }
}
