//
//  AudienceCountCell.swift
//  MovieApp
//
//  Created by Jason on 2023/05/28.
//

import UIKit

final class AudienceCountCell: UICollectionViewCell, ReusableCell {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}
