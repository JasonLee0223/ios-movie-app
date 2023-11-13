//
//  HomeDataSource.swift
//  MovieApp
//
//  Created by Jason on 11/13/23.
//

import UIKit
import RxSwift

final class HomeDataSource: NSObject, UICollectionViewDataSource {
    
    private var viewModel: HomeViewModel?
    private let disposeBag = DisposeBag()
    
    init(viewModel: HomeViewModel) {
        super.init()
        
        self.viewModel = viewModel
        self.viewModel?.state.trendMovieList
            .withUnretained(self)
            .subscribe { owner, trendMovieList in
                trendMovieList.forEach { trendMovie in
                    owner.viewModel?.state.imagePath.onNext(trendMovie.posterImage)
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = HomeSection.allCases[section]
        
        switch sectionType {
        case .trendMoviePoster:
            guard let itemsCount = try? self.viewModel?.state.trendMovieList.value().count else {
                return 0
            }
            return itemsCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrendMovieListCell.reuseIdentifier, 
            for: indexPath) as? TrendMovieListCell else {
            return UICollectionViewCell()
        }
        
        if let trendMovieList = try? self.viewModel?.state.trendMovieList.value() {
            let trendMovie = trendMovieList[indexPath.row]
            cell.configure(trendMovie)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
//        let sectionType = HomeSection.allCases[indexPath.section]
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: HomeHeaderView.reuseIdentifier,
                for: indexPath) as? HomeHeaderView else {
                return UICollectionReusableView()
            }
            headerView.configureOfSortStackLayout()
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
}
