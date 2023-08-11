//
//  BoxOfficeViewController.swift
//  MovieApp
//
//  Created by Jason on 2023/08/10.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOfUI()
        configureHierarchy()
    }
    
    private let collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewLayout()
    )
}


//MARK: - Configure of View
extension BoxOfficeViewController {
    
    private func configureOfUI() {
        configureOfSuperView()
        configureOfCollectionView()
    }
    
    private func configureOfSuperView() {
        self.view.backgroundColor = .black
    }
    
    private func configureOfCollectionView() {
        collectionView.isScrollEnabled = true
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .orange
    }
}

//MARK: - Configure of Layout
extension BoxOfficeViewController {
    
    private func configureHierarchy() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
