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
        self.homeViewModel.action.loadData.onNext(.week)
        self.bindState()
        self.bindCollectionView()
    }
    
    private var homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let navigaionView = NavigationView(rightBarItems: [.boxOffice, .profile])
    private let homeViewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
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
        self.homeCollectionView.isScrollEnabled = true
        self.homeCollectionView.clipsToBounds = false
        self.homeCollectionView.backgroundColor = .black
        self.homeCollectionView.collectionViewLayout = configureOfCollectionViewCompositionalLayout()
        self.homeCollectionView.delegate = self
        self.homeCollectionView.register(
            TrendMovieListCell.self, forCellWithReuseIdentifier: TrendMovieListCell.reuseIdentifier
        )
        self.homeCollectionView.register(
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
        self.view.addSubview(self.homeCollectionView)
        
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
    
    private func bindState() {
        /// Header의 버튼으로 부터 받아온 subPath를 onNext로 줘야함
        /// bind 하는 코드가 필요 이미지 Path에 할당
        self.homeViewModel.state.trendMovieList
            .withUnretained(self)
            .subscribe(onNext: { owner, trendMovieList in
                trendMovieList.forEach { trendMovie in
                    owner.homeViewModel.state.imagePath.onNext(trendMovie.posterImage)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func bindCollectionView() {
        
        self.homeViewModel.state.trendMovieList
            .bind(to: self.homeCollectionView.rx.items(
                cellIdentifier: TrendMovieListCell.reuseIdentifier,
                cellType: TrendMovieListCell.self)
            ) { (row, trendMovie, cell) in
                cell.configure(trendMovie)
            }
            .disposed(by: self.disposeBag)
        
//        homeViewModel.state.userRequestTrendType
//            .bind { [weak self] subPath in
//                guard let self = self else { return }
//                guard let headerView = self.homeCollectionView.dequeueReusableSupplementaryView(
//                    ofKind: UICollectionView.elementKindSectionHeader,
//                    withReuseIdentifier: HomeHeaderView.reuseIdentifier,
//                    for: IndexPath(row: 0, section: 0)
//                ) as? HomeHeaderView else { return }
//
//                Task {
//                    await headerView.selectedTrendDayButton()
//                    await headerView.selectedTrendWeekButton()
//                }
//            }.disposed(by: self.disposeBag)
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
