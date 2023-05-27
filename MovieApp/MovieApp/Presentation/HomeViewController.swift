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
        
        homeSnapShot()
    }
    
    private let viewModel = ViewModel()
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section, BusinessModelWrapper>?
}

//MARK: - Configure of UI Components
extension HomeViewController {
    
    private func configureOfUI() {
        configureOfNavigationBar()
        configureOfSuperView()
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
    
    private func configureColletionViewDelegate() {
        Task {
            collectionView.delegate = self
        }
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
    
    private func homeSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BusinessModelWrapper>()
        
        SectionList.allCases.forEach { sectionList in
            
            //MARK: - TaskGroupTest
//            Task {
//                await viewModel.testTaskGroup(section: sectionList)
//            }
            
            //MARK: - fetchAll
            viewModel.fetchHomeCollectionViewSectionItemsRelated(be: sectionList)
            
            let bindModel = viewModel.sectionStorage[sectionList]
            
            bindModel?.bind(listener: { businessModelWrapper in
                
                guard let bindModels = businessModelWrapper else {
                    print("bindModels Unwrapping Fail...")
                    return
                }
                
                print("✅ 현재 SectionList의 위치")
                print("\(sectionList), keyRawValue = \(sectionList.rawValue)")
                
                let section = Section(type: sectionList, items: bindModels)
                
//                print("✅ 현재 Section 확인중...")
//                print(section.items.isEmpty)
                
                // 섹션 추가
                snapshot.appendSections([section])
                snapshot.appendItems(bindModels)
                self.diffableDataSource?.apply(snapshot)
            })
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

                print("✅ [In HeaderRegistration] 현재 Section 확인중...")
                print(sectionType.type)

                switch sectionType.type {
                case .trendMoviePosterSection:
                    headerView.configureOfSortStackLayout()
                case .stillCutSection:
                    headerView.configureOfStillCutLayout()
                case .koreaMovieListSection:
                    headerView.configureOfKoreaMovieLayout()
                }
            }
        }

        
        diffableDataSource = UICollectionViewDiffableDataSource<Section, BusinessModelWrapper>(collectionView: collectionView)
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
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration,for: index)
        }
        
    }
    
}

//MARK: - Configure of Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("나 눌렸어!")
        
        guard let businessModel = diffableDataSource?.itemIdentifier(
            for: indexPath) else {
            return
        }
        
        let movieDetailViewController = MovieDetailViewController()
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
