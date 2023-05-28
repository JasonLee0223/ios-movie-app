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
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    //MARK: - Public Method
    func configure(_ item: MovieInfo, at indexPath: IndexPath) {
        //TODO: - Model & Cell Components Mapping
    }
}
