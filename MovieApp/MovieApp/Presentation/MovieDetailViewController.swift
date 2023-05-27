//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Jason on 2023/05/28.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOfmovieDetailCollectionView()
        configureHierarchy()
        print("나 왔어!")
    }
    
    private let movieDetailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private func configureHierarchy() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(movieDetailCollectionView)
        
        movieDetailCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieDetailCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            movieDetailCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            movieDetailCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            movieDetailCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func configureOfmovieDetailCollectionView() {
        movieDetailCollectionView.isScrollEnabled = true
        movieDetailCollectionView.clipsToBounds = false
        movieDetailCollectionView.backgroundColor = .black
    }
}
