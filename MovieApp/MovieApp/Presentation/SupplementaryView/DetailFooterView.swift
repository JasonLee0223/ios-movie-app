//
//  DetailFooterView.swift
//  MovieApp
//
//  Created by Jason on 2023/05/29.
//

import UIKit

final class DetailFooterView: UICollectionReusableView, ReusableCell {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        configureOfLayout()
    }
    
    func didSelectedButton() {
        seeMore.sendAction(seeMorebuttonAction)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureOfLayout()
    }
    
    private let seeMorebuttonAction = UIAction { _ in
        print("눌렸어!!!")
    }
    
    private let seeMore: UIButton = {
        let seeMore = UIButton()
        seeMore.setTitle("더보기 ↓", for: .normal)
        seeMore.tintColor = .systemGray5
        seeMore.backgroundColor = .darkGray
        seeMore.layer.cornerRadius = 10
        seeMore.layer.borderWidth = 1
        
        return seeMore
    }()
}

//MARK: - [Private Method] Configure of Layout
extension DetailFooterView {
    
    private func configureOfLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.addSubview(seeMore)
        
        seeMore.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seeMore.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            seeMore.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            seeMore.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            seeMore.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            )
        ])
    }
}

