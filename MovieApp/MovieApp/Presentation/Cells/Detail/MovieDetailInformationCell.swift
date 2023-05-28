//
//  MovieDetailInformationCell.swift
//  MovieApp
//
//  Created by Jason on 2023/05/28.
//

import UIKit

final class MovieDetailInformationCell: UICollectionViewCell, ConfigurableCell {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .yellow
        configureOfLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    //MARK: - Private Property
    
    private let movieSummaryInfo = MovieSummaryInfo()
    
    private let posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.image = UIImage(systemName: "Suzume")
        return posterImage
    }()
    
    private let overView: UILabel = {
        let overView = UILabel()
        overView.font = .systemFont(ofSize: 14)
        overView.textColor = .white
        return overView
    }()
}

//MARK: - [Public Method] Configure of UI Components
extension MovieDetailInformationCell {
    func configure(_ item: MovieInfo, at indexPath: IndexPath) {
        //TODO: - Model & Cell Components Mapping
        
        setOverView(by: "줄거리")
    }
}

//MARK: - [Private Method] Configure of UIComponents
extension MovieDetailInformationCell {
    
    private func setPosterImage(by data: Data) {
        guard let image = UIImage(data: data) else {
            return
        }
        posterImage.image = image
    }
    
    private func setOverView(by text: String) {
        overView.text = text
    }
}

//MARK: - [Private Method] Configure of Layout
extension MovieDetailInformationCell {
    
    private func configureOfLayout() {
//        let safeArea = self.safeAreaLayoutGuide
        
        //TODO: - addSubView를 사용하여 constraint 고민필요
        self.addSubview(posterImage)
        self.addSubview(movieSummaryInfo)
        self.addSubview(overView)
    }
}
