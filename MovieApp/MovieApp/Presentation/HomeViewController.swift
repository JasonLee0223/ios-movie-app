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
        
//        configureOfUI()
//        configureHierarchy()
        
    }
    
    private let viewModel = ViewModel()
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var diffableDataSource: UICollectionViewDiffableDataSource<SectionList, BusinessModelWrapper>?
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
        collectionView.backgroundColor = .black
        collectionView.collectionViewLayout = configureOfCollectionViewCompositionalLayout()
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

//MARK: - Configure of DiffableDataSource
extension HomeViewController {
    
    private func homeSnapShot() -> NSDiffableDataSourceSnapshot<SectionList, BusinessModelWrapper>{
        
        //TODO: - SnapShot 업데이트 및 ViewModel로부터 데이터 받아오기
        
        viewModel.sectionStorage.forEach { (key: SectionList, value: Observable<SectionViewModel>) in
            
            var snapshot = NSDiffableDataSourceSnapshot<SectionList, BusinessModelWrapper>()
            
            SectionList.allCases.forEach { sectionList in
                
                guard let sectionType = viewModel.sectionStorage[sectionList] else { return }
                sectionType.bind { value in
                    self.collectionView.reloadSections(IndexSet(integer: sectionList.index))
                    
                    value?.items.forEach({ businessModelWrapper in
                        switch businessModelWrapper {
                        case .trendMovie(TrendMovie):
                            snapshot.appendSections([.trendMoviePosterSection])
                            snapshot.appendItems([TrendMovie])
                            return snapshot
                            
                        case .stillCut(StillCut):
                            snapshot.appendSections([.stillCutSection])
                            snapshot.appendItems([StillCut])
                            return snapshot
                            
                        case .koreaBoxOfficeList(KoreaBoxOfficeList):
                            snapshot.appendSections([.koreaMovieListSection])
                            snapshot.appendItems([KoreaBoxOfficeList])
                            return snapshot
                        }
                    })
                    
                }
            }
            
        }
    }
    
    private func configureOfDiffableDataSource() {
        
        let trendCellRegistration = UICollectionView.CellRegistration<MovieIntroduceCell, TrendMovie> {
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
        
        diffableDataSource = UICollectionViewDiffableDataSource<SectionList, BusinessModelWrapper>(collectionView: collectionView) {
            (collectionView, indexPath, businessModelWrapper) in
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
        
        diffableDataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HomeHeaderView.reuseIdentifier,
                    for: indexPath
                ) as? HomeHeaderView else {
                    return UICollectionReusableView()
                }
                
                let sectionType = SectionList.allCases[indexPath.section]
                
                switch sectionType {
                case .trendMoviePosterSection:
                    headerView.configureOfSortStackLayout()
                case .stillCutSection:
                    headerView.configureOfStillCutLayout()
                case .koreaMovieListSection:
                    headerView.configureOfKoreaMovieLayout()
                }
                return headerView
            default:
                assert(false, "Invalid UICollectionReusableView")
            }
        }
        
        let snapShot = homeSnapShot()
        diffableDataSource?.apply(snapShot)
    }
}

//viewModel.loadKoreaBoxOfficeMovieList { movieInfo, stillCut, koreaBoxOfficeList in
//    print("=========== [MovieInfo] ===========")
//    print(movieInfo)
//
//    print("=========== [StillCut] ===========")
//    print(stillCut)
//
//    print("=========== [KoreaBoxOfficeList] ===========")
//    print(koreaBoxOfficeList)
//}
