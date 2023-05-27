//
//  HomeViewDataSource.swift
//  MovieApp
//
//  Created by Jason on 2023/05/18.
//

import UIKit

final class HomeViewDataSource: NSObject, UICollectionViewDataSource {
    
    override init() {
        self.viewModel = ViewModel()
        super.init()
    }
    
    //MARK: - Number Of Section and Item
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionList.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        viewModel.countItem(section: section)
        return 0
    }
    
    //MARK: - HeaderView
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeHeaderView.reuseIdentifier,
                for: indexPath) as? HomeHeaderView else {
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
            print("해당되는 Header SectionType이 없습니다.")
            return UICollectionReusableView()
        }
    }
    
    //MARK: - ColletionViewCell
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch SectionList(rawValue: indexPath.section) {
            
        case .trendMoviePosterSection:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrendMovieListCell.reuseIdentifier,
                for: indexPath) as? TrendMovieListCell else {
                return UICollectionViewCell()
            }
            
//            viewModel.loadTrendOfWeekMovieListFromTVDB { trendMovieListStorage in
//
//                trendMovieListStorage.forEach { trendMovieList in
//
//                    self.viewModel.fetchImage(imagePath: trendMovieList.posterImagePath) { imageData in
//
//                        DispatchQueue.main.async {
//                            guard let image = UIImage(data: imageData) else {
//                                return
//                            }
//                            cell.setPoster(with: image)
//                            cell.setPoster(with: trendMovieList.posterName)
//                        }
//                    }
//                }
//            }
            
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
            
            return cell
            
        case .stillCutSection:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieStillCutCell.reuseIdentifier,
                for: indexPath) as? MovieStillCutCell else {
                return UICollectionViewCell()
            }
            
//            let item = items[indexPath.item]
//            cell.setGenrePoster(with: item.genreImage)
            return  cell
            
        case .koreaMovieListSection:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: KoreaBoxOfficeListCell.reuseIdentifier,
                for: indexPath) as? KoreaBoxOfficeListCell else {
                return UICollectionViewCell()
            }
            
//            let item = items[indexPath.item]
//            cell.rankView.setRank(by: item.rank)
//            cell.rankView.setRankVariation(by: item.rankVariation)
//            cell.rankView.setRankVariation(by: UIColor.black)
//
//            cell.rankView.setRankImage(by: UIImage(named: "Suzume"))
//            cell.rankView.setRankImage(by: UIColor.black)
//
//            cell.summaryInformationView.setMovieName(by: item.movieName)
//            cell.summaryInformationView.setAudienceCount(by: item.audienceCount)
            return  cell
        case .none:
            print("해당 Section의 Cell을 찾을 수 없음")
            return UICollectionViewCell()
        }
    }
    
    private let viewModel: ViewModel
}
