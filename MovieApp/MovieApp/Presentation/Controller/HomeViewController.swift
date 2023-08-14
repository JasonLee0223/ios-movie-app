//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

final class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOfUI()
        configureHierarchy()
        configureOfDiffableDataSource()
        
        checkOfBindCompleted()
    }
    
    private let homeViewModel = HomeViewModel()
    
    private var homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<HomeSection, TrendMovie>?
    
    private var snapshot = NSDiffableDataSourceSnapshot<HomeSection, TrendMovie>()
    
    private lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(
        frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 300, height: 100))
    )
    
    private lazy var refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(handleRefreshControl) , for: .valueChanged)
        return refreshControl
    }()
    
    @objc func handleRefreshControl() {
        
        snapshot = .init()
        
        homeSnapShot { _ in
            Task {
                self.refresh.endRefreshing()
            }
        }
    }
}

//MARK: - Configure of UI Components
extension HomeViewController {
    
    private func configureOfUI() {
        configureOfActivityIndicator()
        checkOfAnimatingActivityIndicator(isAnimated: true)
        
        configureOfSuperView()
        configureOfNavigationBar()
        
        configureOfCollectionView()
        configureColletionViewDelegate()
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
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.backgroundColor = .black
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navigationAppearance
        
        self.navigationItem.leftBarButtonItem = .init(customView: title)
    }
    
    private func configureOfCollectionView() {
        homeCollectionView.isScrollEnabled = true
        homeCollectionView.clipsToBounds = false
        homeCollectionView.backgroundColor = .black
        homeCollectionView.collectionViewLayout = configureOfCollectionViewCompositionalLayout()
        homeCollectionView.refreshControl = refresh
    }
    
    private func checkOfAnimatingActivityIndicator(isAnimated: Bool) {
        
        guard isAnimated != activityIndicator.isAnimating else { return }
                
        if isAnimated {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    private func configureOfActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.color = .white
        activityIndicator.style = .large
        activityIndicator.isHidden = false
    }
    
    private func configureColletionViewDelegate() {
        Task {
            homeCollectionView.delegate = self
        }
    }
}

//MARK: - Configure of Layout
extension HomeViewController {
    
    private func configureHierarchy() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(homeCollectionView)
        self.view.addSubview(activityIndicator)
        
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            homeCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func configureOfCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            return HomeViewLayout(sectionIndex: sectionIndex).create()
        }
    }
}

//MARK: - Configure of DiffableDataSource
extension HomeViewController {
    
    private func homeSnapShot(completion: @escaping (Bool) -> Void) {
        
        HomeSection.allCases.forEach { section in
            
            Task {
                let apiData = await homeViewModel.loadTrendOfWeekMovieListFromTMDB()
                
                snapshot.appendSections([section])
                snapshot.appendItems(apiData)
                await diffableDataSource?.apply(snapshot, animatingDifferences: true)
                completion(true)
            }
        }
    }
    
    private func checkOfBindCompleted() {
        homeSnapShot { isCompleted in
            Task {
                if isCompleted {
                    let activityIndicatorAnimatedState = !isCompleted
                    self.checkOfAnimatingActivityIndicator(isAnimated: activityIndicatorAnimatedState)
                }
            }
        }
    }
    
    private func configureOfDiffableDataSource() {
        
        let trendCellRegistration = UICollectionView.CellRegistration<TrendMovieListCell, TrendMovie> {
            (cell, indexPath, trendMovie) in
            cell.configure(trendMovie, at: indexPath)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<HomeHeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) {
            (headerView, elementKind, indexPath) in
            
            headerView.configureOfSortStackLayout()
            
            Task {
                await headerView.selectedTrendWeekButton()
                await headerView.selectedTrendDayButton()
            }
        }
        
        diffableDataSource = UICollectionViewDiffableDataSource<HomeSection, TrendMovie>(
            collectionView: homeCollectionView, cellProvider: { (collectionView, indexPath, itemOfTrendMovie) in
                collectionView.dequeueConfiguredReusableCell(
                    using: trendCellRegistration, for: indexPath, item: itemOfTrendMovie
                )
            }
        )
        diffableDataSource?.supplementaryViewProvider = { (view, kind, index) in
            return self.homeCollectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: index
            )
        }
    }
    
}

//MARK: - Configure of Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        guard let businessModelWrapper = diffableDataSource?.itemIdentifier(
//            for: indexPath) else {
//            return
//        }
        
        let movieDetailViewController = MovieDetailViewController()
//        movieDetailViewController.movieDetailData = businessModelWrapper
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
