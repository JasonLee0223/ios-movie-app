//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

final class HomeViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        HomeSection.allCases.forEach { section in
            Task {
                homeViewModel.fetchHomeCollectionViewSectionItemsRelated(be: section)
            }
        }
        
        configureOfActivityIndicator()
        if loadCount == 0 {
            checkOfAnimatingActivityIndicator(isAnimated: animated)
        } else {
            checkOfAnimatingActivityIndicator(isAnimated: !animated)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOfUI()
        configureHierarchy()
        configureOfDiffableDataSource()
        bindCollectionView()
    }
    
    private var loadCount = 0
    private let homeViewModel = HomeViewModel()
    private var homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var diffableDataSource: UICollectionViewDiffableDataSource<HomeSection, HomeEntityWrapper>?
    
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
        homeSnapShot { isCompleted in
            print(isCompleted)
            Task {
                self.refresh.endRefreshing()
            }
        }
    }
}

//MARK: - Configure of UI Components
extension HomeViewController {
    
    private func configureOfUI() {
        self.view.backgroundColor = .black
        configureOfNavigationBar()
        configureOfCollectionView()
        configureColletionViewDelegate()
    }
    
    private func configureOfNavigationBar() {
        //TODO: - Button에 대한 Action이 필요하면 UIImageView를 클로저 형태로 변경
        
        let title = UIButton()
        let hambergImage = UIImage(named: MagicLiteral.RelatedToNavigationController.hambergImageName)
        let ticketImage = UIImage(named: MagicLiteral.RelatedToNavigationController.ticketImageName)
        let hambergImageView = UIImageView(image: hambergImage)
        let ticketImageView = UIImageView(image: ticketImage)
        let hamberg = UIBarButtonItem(customView: hambergImageView)
        let ticket = UIBarButtonItem(customView: ticketImageView)
        let map = UIBarButtonItem()
            
        title.setTitle(MagicLiteral.RelatedToNavigationController.navigationTitle, for: .normal)
        title.titleLabel?.font = UIFont.systemFont(ofSize: MagicNumber.Attributes.navigationBarButtonFont, weight: .bold)
        title.tintColor = .white
        map.image = UIImage(systemName: MagicLiteral.RelatedToNavigationController.mapImageName)
        map.tintColor = .white
        
        self.navigationItem.leftBarButtonItem = .init(customView: title)
        self.navigationItem.rightBarButtonItems = [hamberg, map, ticket]
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func configureOfCollectionView() {
        homeCollectionView.isScrollEnabled = true
        homeCollectionView.clipsToBounds = true
        homeCollectionView.backgroundColor = .black
        homeCollectionView.collectionViewLayout = configureOfCollectionViewCompositionalLayout()
        homeCollectionView.refreshControl = refresh
    }
    
    private func configureOfActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.color = .white
        activityIndicator.style = .large
        activityIndicator.isHidden = false
    }
    
    private func checkOfAnimatingActivityIndicator(isAnimated: Bool) {
        guard isAnimated != activityIndicator.isAnimating else { return }
                
        if isAnimated {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
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
            homeCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
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
            
            let bindModel = homeViewModel.sectionStorage[section]
            
            bindModel?.bind(listener: { [weak self] businessModelWrapper in
                guard let self = self else { return }
                loadCount += 1
                
                if loadCount == HomeSection.allCases.count {
                    var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeEntityWrapper>()
                
                    snapshot.appendSections([.trendMoviePoster, .stillCut, .koreaMovieList])
                    
                    if let trendMovies = homeViewModel.sectionStorage[.trendMoviePoster]?.value {
                        snapshot.appendItems(trendMovies, toSection: .trendMoviePoster)
                    }
                    if let stillCuts = homeViewModel.sectionStorage[.stillCut]?.value {
                        snapshot.appendItems(stillCuts, toSection: .stillCut)
                    }
                    if let boxOfficeList = homeViewModel.sectionStorage[.koreaMovieList]?.value {
                        snapshot.appendItems(boxOfficeList, toSection: .koreaMovieList)
                    }
                    self.diffableDataSource?.apply(snapshot, animatingDifferences: true)
                    completion(true)
                }
            })
        }
    }
    
    private func bindCollectionView() {
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
        
        let stillCusRegistration = UICollectionView.CellRegistration<MovieStillCutCell, StillCut> {
            (cell, indexPath, stillCut) in
            cell.configure(stillCut, at: indexPath)
        }
        
        let koreaBoxOfficeListCellRegistration = UICollectionView.CellRegistration<KoreaBoxOfficeListCell, KoreaBoxOfficeList> {
            (cell, indexPath, koreaBoxOfficeList) in
            cell.configure(koreaBoxOfficeList, at: indexPath)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<HomeHeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) {
            (headerView, elementKind, indexPath) in
            
            if let sectionType = self.diffableDataSource?.sectionIdentifier(
                for: indexPath.section) {
                
                switch sectionType {
                case .trendMoviePoster:                    
                    Task {
                        await headerView.selectedTrendWeekButton()
                        await headerView.selectedTrendDayButton()
                    }
                    headerView.configureOfSortStackLayout()
                case .stillCut:
                    headerView.configureOfStillCutLayout()
                case .koreaMovieList:
                    headerView.configureOfKoreaMovieLayout()
                }
            }
        }
        
        diffableDataSource = UICollectionViewDiffableDataSource<HomeSection, HomeEntityWrapper>(collectionView: homeCollectionView)
        { (collectionView, indexPath, businessModelWrapper) in
            
            switch businessModelWrapper {
            case let .trendMovie(trendMovieItem):
                return collectionView.dequeueConfiguredReusableCell(
                    using: trendCellRegistration, for: indexPath, item: trendMovieItem
                )
            case let .stillCut(stillCutItem):
                return collectionView.dequeueConfiguredReusableCell(
                    using: stillCusRegistration, for: indexPath, item: stillCutItem
                )
            case let .koreaBoxOfficeList(koreaBoxOfficeListItem):
                return collectionView.dequeueConfiguredReusableCell(
                    using: koreaBoxOfficeListCellRegistration, for: indexPath, item: koreaBoxOfficeListItem
                )
            }
        }
        
        diffableDataSource?.supplementaryViewProvider = { (view, kind, index) in
            return self.homeCollectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration,for: index)
        }
    }
}

//MARK: - Configure of Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let businessModelWrapper = diffableDataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.movieDetailData = businessModelWrapper
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
