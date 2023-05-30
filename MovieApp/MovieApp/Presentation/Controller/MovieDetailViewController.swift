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
        
        configureOfUI()
        configureOfDetailDiffableDataSource()
    }
    
    var movieDetailData: BusinessModelWrapper?
    
    private let movieDetailCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewLayout()
    )
    private let dataSource = MovieDetailDataSource()
    
//    private let detailDiffableDataSource: UICollectionViewDiffableDataSource<DetailSectionList, MovieInfo>?
}

//MARK: - [Private Method] Configure of UI Components
extension MovieDetailViewController {
    
    private func configureOfUI() {
        print("✅ Current Movie Detail ViewController ❗️")
        
        configureOfSuperView()
        configureOfmovieDetailCollectionView()
        configureHierarchy()
    }
    
    private func configureOfSuperView() {
        self.view.backgroundColor = .systemGray
    }
    
    private func configureOfmovieDetailCollectionView() {
        movieDetailCollectionView.isScrollEnabled = true
        movieDetailCollectionView.clipsToBounds = true
        movieDetailCollectionView.backgroundColor = .white
        movieDetailCollectionView.collectionViewLayout = configureOfCollectionViewCompositionalLayout()
        movieDetailCollectionView.dataSource = dataSource
        movieDetailCollectionView.contentInsetAdjustmentBehavior = .never
        
        movieDetailCollectionView.register(
            DetailHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: DetailHeaderView.reuseIdentifier
        )
        movieDetailCollectionView.register(
            MovieDetailInformationCell.self,
            forCellWithReuseIdentifier: MovieDetailInformationCell.reuseIdentifier
        )
        movieDetailCollectionView.register(
            MovieCreditCell.self,
            forCellWithReuseIdentifier: MovieCreditCell.reuseIdentifier
        )
        movieDetailCollectionView.register(
            AudienceCountCell.self,
            forCellWithReuseIdentifier: AudienceCountCell.reuseIdentifier
        )
    }
}

//MARK: - [Private Method] Configure of Layout
extension MovieDetailViewController {
    
    private func configureHierarchy() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(movieDetailCollectionView)
        
        movieDetailCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieDetailCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            movieDetailCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            movieDetailCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            movieDetailCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func configureOfCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            return MovieDetailViewLayout(sectionIndex: sectionIndex).create()
        }
    }
    
}

//MARK: - [Private Method]
extension MovieDetailViewController {
    
    private func configureOfDetailDiffableDataSource() {
        let movieDetailInformationRegistration = UICollectionView.CellRegistration<MovieDetailInformationCell, MovieInfo> {
            (cell, indexPath, movieInfo) in
            
            cell.configure(movieInfo, at: indexPath)
        }
        
        let moiveOfficialsRegistration = UICollectionView.CellRegistration<MovieCreditCell, MovieInfo> {
            (cell, indexPath, moiveInfo) in
            
            // MockData to test
            let mockData = ["스즈메", "문단속", "스즈메", "문단속", "스즈메", "문단속", "스즈메", "문단속",]
            
            cell.configure(mockData, at: indexPath)
        }
        
        let koreaBoxOfficeListCellRegistration = UICollectionView.CellRegistration<KoreaBoxOfficeListCell, MovieInfo> {
            (cell, indexPath, movieInfo) in
            
            //TODO: - Core Graphic을 사용한 관객수 그래프화 or Label로 보여주기
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<DetailHeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) {
            (headerView, elementKind, indexPath) in
            
            let sectionType = DetailSectionList.allCases[indexPath.section]
            
            switch sectionType {
            case .movieDetailInformationSection:
                return
            case .movieOfficialsSection:
                return headerView.configureOfMovieOfficialsLayout()
            case .audienceCountSection:
                return headerView.configureOfaudienceCountLayout()
            }
        }
        
//        detailDiffableDataSource = UICollectionViewDiffableDataSource<DetailSectionList, MovieInfo>(collectionView: movieDetailCollectionView) {
//            (collectionView, indexPath, businessModelWrapper) in
//
//        }
    }
}
