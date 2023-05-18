//
//  HomeViewDataSource.swift
//  MovieApp
//
//  Created by Jason on 2023/05/18.
//

import UIKit

enum HomeSection {
    case introduce([IntroduceItem])
    case Genre([GenreItem])
    
    struct IntroduceItem {
        let posterImage: UIImage
        let posterName: String
    }
    
    struct GenreItem {
        let genreImage: UIImage
        let genreName: String
    }
}

final class HomeViewDataSource: NSObject, UICollectionViewDataSource {
    
    var mockData: [HomeSection] = [ .introduce([HomeSection.IntroduceItem.init(posterImage: UIImage(systemName: "square.fill")!,
                                                                               posterName: "포스터 이름")]),
                                    .Genre([HomeSection.GenreItem.init(genreImage: UIImage(systemName: "square.fill")!,
                                                                       genreName: "장르 이름")])
    ]
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mockData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        switch mockData[section] {
        case let .introduce(items):
            return items.count
        case let .Genre(items):
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: HomeHeaderView.identifier,
                                                                                   for: indexPath) as? HomeHeaderView else {
                return UICollectionReusableView()
            }
            
            let sectionType = CellList.allCases[indexPath.section]
            
            switch sectionType {
            case .IntroducePosterSection:
                headerView.configureOfGenreLayout()
            case .GenrePosterSection:
                headerView.configureOfSortStackLayout()
            }
            return headerView
            
        default:
            print("해당되는 Header SectionType이 없습니다.")
            return UICollectionReusableView()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch mockData[indexPath.section] {
        case let .introduce(items):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieIntroduceCell.identifier,
                                                                for: indexPath) as? MovieIntroduceCell else {
                return UICollectionViewCell()
            }
            let item = items[indexPath.item]
            cell.setPoster(with: item.posterImage)
            cell.setPoster(with: item.posterName)
            return cell
        case let .Genre(items):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieGenreCell.identifier,
                                                                for: indexPath) as? MovieGenreCell else {
                return UICollectionViewCell()
            }
            let item = items[indexPath.item]
            cell.setGenrePoster(with: item.genreImage)
            cell.setGenreType(with: item.genreName)
            return  cell
        }
    }
}
