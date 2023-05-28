//
//  MovieDetailInformationView.swift
//  MovieApp
//
//  Created by Jason on 2023/05/28.
//

import UIKit

final class MovieDetailInformationView: UIStackView {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
        
        configureOfStackView()
        configureOfComponents()
        configureOfLayout()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureOfStackView()
        configureOfComponents()
        configureOfLayout()
    }
    
    private let movieSummaryInfo = MovieSummaryInfo(
//        frame: .init(
//            origin: CGPoint(x: 0, y: 0),
//            size: CGSize(width: 300, height: 300)
//        )
    )
    
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

//MARK: - Public Method
extension MovieDetailInformationView {
    
    func configureOfComponents() {
        // mockData
        
        setOverView(by: "줄거리")
    }
}

//MARK: - Private Method
extension MovieDetailInformationView {
    
    private func configureOfLayout() {
//        let safeArea = self.safeAreaLayoutGuide
        
        //TODO: - addSubView를 사용하여 constraint 고민필요
        self.addSubview(posterImage)
        self.addSubview(movieSummaryInfo)
        self.addSubview(overView)
    }
    
    private func configureOfStackView() {
        axis = .vertical
        alignment = .leading
        distribution = .fill
    }
    
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
