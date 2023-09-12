//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Jason on 2023/05/28.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    //MARK: - Property
    
    var movieDetailData: TrendMovie?
    
    var posterImageDataReceivedFromHomeView: Data?
    
    //MARK: - Override Method
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        posterImageDataReceivedFromHomeView = movieDetailData?.posterImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOfUI()
        configureOfDetailDiffableDataSource()
        
        detailSnapShot()
    }
    
    //MARK: - Private Property
    private let movieDetailCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewLayout()
    )
    
    private let detailViewModel = DetailViewModel()
    
    private var detailDiffableDataSource: UICollectionViewDiffableDataSource<DetailSectionList, DetailEntityWrapper>?
    
    private var snapshot = NSDiffableDataSourceSnapshot<DetailSectionList, DetailEntityWrapper>()
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
        movieDetailCollectionView.contentInsetAdjustmentBehavior = .never
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

//MARK: - [Private Method] Configure of DiffableDataSource
extension MovieDetailViewController {
    
    private func detailSnapShot() {
        
        DetailSectionList.allCases.forEach { sectionList in
            
            if let movieCode = movieDetailData?.movieCode {
                
                Task {
//                    guard let storage = await detailViewModel.fetchDataAccording(to: sectionList, and:movieCode) else { return }
                    
//                    snapshot.appendSections([sectionList])
//                    snapshot.appendItems(storage)
//                    await detailDiffableDataSource?.apply(snapshot, animatingDifferences: true)
                }
            }
        }
    }
    
    private func configureOfDetailDiffableDataSource() {
        let movieDetailInformationRegistration = UICollectionView.CellRegistration<MovieDetailInformationCell, MovieInformation> {
            (cell, indexPath, movieInformation) in
            
            guard let unwarppingposterImageDataReceivedFromHomeView = self.posterImageDataReceivedFromHomeView else {
                print(DetailViewModelInError.failOfUnwrapping)
                return
            }
            
            cell.configure(movieInformation, at: indexPath,
                posterImageData: unwarppingposterImageDataReceivedFromHomeView
            )
        }
        
        let moiveOfficialsRegistration = UICollectionView.CellRegistration<MovieCreditCell, MovieCast> {
            (cell, indexPath, moiveCast) in
            
            cell.configure(moiveCast, at: indexPath)
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
        
        detailDiffableDataSource = UICollectionViewDiffableDataSource<DetailSectionList, DetailEntityWrapper>(
            collectionView: movieDetailCollectionView) {
            (collectionView, indexPath, detailEntityWrapper) in

            switch detailEntityWrapper {
            case let .movieDetailInformation(movieInformationItem):
                return collectionView.dequeueConfiguredReusableCell(
                    using: movieDetailInformationRegistration, for: indexPath, item: movieInformationItem
                )
            case let .movieCast(movieCastItem):
                return collectionView.dequeueConfiguredReusableCell(
                    using: moiveOfficialsRegistration, for: indexPath, item: movieCastItem
                )
            }
        }

        detailDiffableDataSource?.supplementaryViewProvider = {
            (view, kind, index) in
            return self.movieDetailCollectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,for: index
            )
        }
    }
}
