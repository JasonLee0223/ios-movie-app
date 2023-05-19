//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOfUI()
        configureHierarchy()
    }
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var dataSource = HomeViewDataSource()
    
}

//MARK: - Configure of UI Components
extension HomeViewController {
    
    private func configureOfUI() {
        configureOfNavigationBar()
        configureOfSuperView()
        configureOfCollectionView()
    }
    
    private func configureOfSuperView() {
        self.view.backgroundColor = .black
    }
    
    private func configureOfNavigationBar() {
        let title: UIButton = {
            let title = UIButton()
            title.setTitle(
                MagicLiteral.RelatedToNavigationController.navigationTitle,
                for: .normal
            )
            title.titleLabel?.font = UIFont.systemFont(
                ofSize: MagicNumber.Attributes.navigationBarButtonFont,
                weight: .bold
            )
            title.tintColor = .white
            return title
        }()
        
        //TODO: - Button에 대한 Action이 필요하면 UIImageView를 클로저 형태로 변경
        let hamberg: UIBarButtonItem = {
            let hambergImage = UIImage(named: MagicLiteral.RelatedToNavigationController.hambergImageName)
            let hambergImageView = UIImageView(image: hambergImage)
            let hamberg = UIBarButtonItem(customView: hambergImageView)
            return hamberg
        }()
        
        let ticket: UIBarButtonItem = {
            let ticketImage = UIImage(named: MagicLiteral.RelatedToNavigationController.ticketImageName)
            let ticketImageView = UIImageView(image: ticketImage)
            let ticket = UIBarButtonItem(customView: ticketImageView)
            return ticket
        }()
        
        let map: UIBarButtonItem = {
            let map = UIBarButtonItem()
            map.image = UIImage(systemName: MagicLiteral.RelatedToNavigationController.mapImageName)
            map.tintColor = .white
            return map
        }()
        
        self.navigationItem.leftBarButtonItem = .init(customView: title)
        self.navigationItem.rightBarButtonItems = [hamberg, map, ticket]
    }
    
    private func configureOfCollectionView() {
        collectionView.isScrollEnabled = true
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .systemBackground
        collectionView.collectionViewLayout = configureOfCollectionViewCompositionalLayout()
        collectionView.dataSource = dataSource
        
        collectionView.register(HomeHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HomeHeaderView.identifier)
        collectionView.register(MovieIntroduceCell.self, forCellWithReuseIdentifier: MovieIntroduceCell.identifier)
        collectionView.register(MovieGenreCell.self, forCellWithReuseIdentifier: MovieGenreCell.identifier)
    }
}

//MARK: - Configure of Layout
extension HomeViewController {
    
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
    
    private func configureOfCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            return HomeViewLayout(sectionIndex: sectionIndex).create()
        }
    }
}
