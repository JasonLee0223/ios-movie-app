//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Jason on 2023/05/28.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    //MARK: - Property
    
    var movieDetailData: HomeEntityWrapper?
    var posterImageDataReceivedFromHomeView: Data?
    
    //MARK: - Override Method
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch movieDetailData {
        case let .trendMovie(movieDetailData):
            posterImageDataReceivedFromHomeView = movieDetailData.posterImage
            Task {
                await detailViewModel.loadNeedTotMovieDetailSection(movieCode: movieDetailData.movieCode)
            }
        case let .stillCut(movieDetailData):
            posterImageDataReceivedFromHomeView = movieDetailData.genreImagePath
            
        case let .koreaBoxOfficeList(movieDetailData):
            print(movieDetailData)
            // 이미지 필요
        case .none:
            print("Value of Optional so value is nil")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOfUI()
        configureOfDetailDiffableDataSource()
        
        detailSnapShot()
    }
    
    //MARK: - Private Property
    private let detailViewModel = DetailViewModel()
    private let dataSource = MovieDetailDataSource()
    private let movieDetailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var detailDiffableDataSource: UICollectionViewDiffableDataSource<DetailSection, DetailEntityWrapper>?
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
            movieDetailCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
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
        
        DetailSection.allCases.forEach { section in
            
            let bindModel = detailViewModel.sectionStroage[section]
            
            bindModel?.bind(listener: { [weak self] businessModelWrapper in
                
                guard let self = self else { return }
                
                var snapshot = NSDiffableDataSourceSnapshot<DetailSection, DetailEntityWrapper>()
                snapshot.appendSections([.movieDetailInformationSection, .movieOfficialsSection, .audienceCountSection])
                
                if let movieDetailInfo = detailViewModel.sectionStroage[.movieDetailInformationSection]?.value {
                    snapshot.appendItems(movieDetailInfo, toSection: .movieDetailInformationSection)
                }
                
                if let movieOfficial = detailViewModel.sectionStroage[.movieOfficialsSection]?.value {
                    snapshot.appendItems(movieOfficial, toSection: .movieOfficialsSection)
                }
                
                if let audienceCount = detailViewModel.sectionStroage[.audienceCountSection]?.value {
                    snapshot.appendItems(audienceCount, toSection: .audienceCountSection)
                }
                self.detailDiffableDataSource?.apply(snapshot, animatingDifferences: true)
            })
        }
    }
    
    private func configureOfDetailDiffableDataSource() {
        let movieDetailInformationRegistration = UICollectionView.CellRegistration<MovieDetailInformationCell, MovieInformation> {
            (cell, indexPath, movieInformation) in
            
            guard let unwarppingposterImageDataReceivedFromHomeView = self.posterImageDataReceivedFromHomeView else {
                print(DetailViewModelInError.failOfUnwrapping)
                return
            }
            
            cell.configure(movieInformation,at: indexPath,
                           posterImageData: unwarppingposterImageDataReceivedFromHomeView)
        }
        
        let moiveOfficialsRegistration = UICollectionView.CellRegistration<MovieCreditCell, MovieCast> {
            (cell, indexPath, moiveCast) in
            
            cell.configure(moiveCast, at: indexPath)
        }
        
        let koreaBoxOfficeListCellRegistration = UICollectionView.CellRegistration<KoreaBoxOfficeListCell, MovieInfo> {
            (cell, indexPath, movieInfo) in
            
            //TODO: - Core Graphic을 사용한 관객수 그래프화 or Label로 보여주기
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<DetailHeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) {
            (headerView, elementKind, indexPath) in
            
            let sectionType = DetailSection.allCases[indexPath.section]
            
            switch sectionType {
            case .movieDetailInformationSection:
                return
            case .movieOfficialsSection:
                return headerView.configureOfMovieOfficialsLayout()
            case .audienceCountSection:
                return headerView.configureOfaudienceCountLayout()
            }
        }
        
        detailDiffableDataSource = UICollectionViewDiffableDataSource<DetailSection, DetailEntityWrapper>(collectionView: movieDetailCollectionView) {
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
        
        detailDiffableDataSource?.supplementaryViewProvider = { (view, kind, index) in
            return self.movieDetailCollectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration,for: index)
        }
    }
}
