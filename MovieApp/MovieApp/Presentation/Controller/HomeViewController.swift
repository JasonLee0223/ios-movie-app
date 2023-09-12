//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

import RxSwift
import SnapKit

final class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOfUI()
        configureHierarchy()
//        configureOfDiffableDataSource()
//
//        checkOfBindCompleted()
    }
    
    private let navigaionView = NavigationView(rightBarItems: [.boxOffice, .profile])
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
    
    private let disposeBag = DisposeBag()
    
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
//        configureOfNavigationBar()
        configureOfTabBar()
        
        configureOfCollectionView()
        configureColletionViewDelegate()
    }
    
    private func configureOfSuperView() {
        self.view.backgroundColor = .black
    }
    
    private func configureOfNavigationBar() {
        let title: UILabel = {
            let title = UILabel()
            title.text = MagicLiteral.RelatedToNavigationController.navigationTitle
            title.textColor = .systemGreen
            title.font = .boldSystemFont(ofSize: MagicNumber.Attributes.navigationBarButtonFont)
            return title
        }()
        
        //        let profile: UIButton = {
        //            var config = UIButton.Configuration.bordered()
        //            config.buttonSize = .medium
        //            config.baseBackgroundColor = .black
        //            config.baseForegroundColor = .systemGray5
        //
        //            let profile = UIButton(configuration: config)
        //            profile.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        //            return profile
        //        }()
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.backgroundColor = .black
        navigationController?.navigationBar.standardAppearance = navigationAppearance
        self.navigationItem.leftBarButtonItem = .init(customView: title)
        //        self.navigationItem.rightBarButtonItem = .init(customView: profile)
    }
    
    private func configureOfTabBar() {
        let tabbarAppearance = UITabBarAppearance()
        tabbarAppearance.backgroundColor = .black
        tabbarAppearance.selectionIndicatorTintColor = .white
        tabBarController?.tabBar.standardAppearance = tabbarAppearance
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
        
        self.view.addSubview(self.navigaionView)
        self.view.addSubview(self.homeCollectionView)
        self.view.addSubview(self.activityIndicator)
        
        self.navigaionView.snp.makeConstraints { make in
            let safeArea = self.view.safeAreaLayoutGuide
            make.top.leading.trailing.equalTo(safeArea)
        }
        
        self.homeCollectionView.snp.makeConstraints { make in
            let safeArea = self.view.safeAreaLayoutGuide
            make.top.equalTo(self.navigaionView.snp.bottom)
            make.leading.trailing.bottom.equalTo(safeArea)
        }
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
        
        homeViewModel.action.loadData.onNext(.week)
        homeViewModel.state.trendMovieList
            .withUnretained(self)
            .subscribe(onNext: { owner, trendMovieList in
                trendMovieList.forEach { trendMovie in
                    print(trendMovie.posterName)
                }
            })
            .disposed(by: self.disposeBag)
        

//        snapshot.appendSections([section])
//        snapshot.appendItems(apiData)
//        await diffableDataSource?.apply(snapshot, animatingDifferences: true)
//        completion(true)
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
        
        guard let selectedItem = diffableDataSource?.itemIdentifier(for: indexPath) else { return }
        
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.movieDetailData = selectedItem
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
