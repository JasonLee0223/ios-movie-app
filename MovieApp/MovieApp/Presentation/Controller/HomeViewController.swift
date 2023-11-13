//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.viewModel.action.loadData.onNext(.week)
        self.viewModel.state.trendMovieList
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (owner, _) in
                owner.collectionView.reloadData()
            })
            .disposed(by: self.disposeBag)
    }
    
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel()
    private let navigaionView = NavigationView(rightBarItems: [.boxOffice, .profile])
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private lazy var dataSource = HomeDataSource(viewModel: self.viewModel)
}

//MARK: - Configure of UI Components
extension HomeViewController {
    
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.configureOfSuperView()
        self.configureOfTabBar()
        self.configureOfCollectionView()
    }
    
    private func configureOfSuperView() {
        self.view.backgroundColor = .black
    }
    
    private func configureOfTabBar() {
        let tabbarAppearance = UITabBarAppearance()
        tabbarAppearance.backgroundColor = .black
        tabbarAppearance.selectionIndicatorTintColor = .white
        tabBarController?.tabBar.standardAppearance = tabbarAppearance
    }
    
    private func configureOfCollectionView() {
        self.collectionView.isScrollEnabled = true
        self.collectionView.clipsToBounds = false
        self.collectionView.backgroundColor = .black
        self.collectionView.collectionViewLayout = configureOfCollectionViewCompositionalLayout()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self.dataSource
        self.collectionView.register(
            TrendMovieListCell.self, forCellWithReuseIdentifier: TrendMovieListCell.reuseIdentifier
        )
        self.collectionView.register(
            HomeHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeHeaderView.reuseIdentifier
        )
    }
}

//MARK: - Configure of Layout
extension HomeViewController {
    
    private func setupLayout() {
        
        self.view.addSubview(self.navigaionView)
        self.view.addSubview(self.collectionView)
        
        self.navigaionView.snp.makeConstraints { make in
            let safeArea = self.view.safeAreaLayoutGuide
            make.top.leading.trailing.equalTo(safeArea)
        }
        
        self.collectionView.snp.makeConstraints { make in
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

//MARK: - Configure of Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieDetailViewController = MovieDetailViewController()
//        movieDetailViewController.movieDetailData = selectedItem
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
