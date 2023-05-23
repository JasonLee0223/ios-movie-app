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
    case KoreaBoxOffice([KoreaBoxOfficeItem])
    
    struct IntroduceItem {
        let posterImage: UIImage
        let posterName: String
    }
    
    struct GenreItem {
        let genreImage: UIImage
    }
    
    struct KoreaBoxOfficeItem {
        let openDate: String
        let rank: String
        let rankOldAndNew: RankOldAndNew
        let rankVariation: String
    
        let movieName: String
        let audienceCount: String
        let audienceAccumulated: String
    }
}


final class HomeViewDataSource: NSObject, UICollectionViewDataSource {
    
    var mockData: [HomeSection] = [
        .introduce([HomeSection.IntroduceItem].init(
        repeating: HomeSection.IntroduceItem(
            posterImage: UIImage(named: "Suzume")!,
            posterName: "포스터 이름"),
        count: MagicNumber.RelatedToDataSource.numberOfPosterCount)
        ),
        
        .Genre([HomeSection.GenreItem].init(
            repeating: HomeSection.GenreItem(
                genreImage: UIImage(named: "Suzume")!
            ),
            count: MagicNumber.RelatedToDataSource.numberOfGenreCount)
        ),
        
        .KoreaBoxOffice([HomeSection.KoreaBoxOfficeItem].init(
        repeating: HomeSection.KoreaBoxOfficeItem(
            openDate: "2023-05-22",
            rank: "1",
            rankOldAndNew: .new,
            rankVariation: "123456789",
            movieName: "영화 제목",
            audienceCount: "1234512345",
            audienceAccumulated: "1000000000"),
        count: 10)
        )
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
        case let .KoreaBoxOffice(items):
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeHeaderView.identifier,
                for: indexPath) as? HomeHeaderView else {
                return UICollectionReusableView()
            }
            
            let sectionType = CellList.allCases[indexPath.section]
            
            switch sectionType {
            case .IntroducePosterSection:
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
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch mockData[indexPath.section] {
            
        case let .introduce(items):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieIntroduceCell.identifier,
                for: indexPath) as? MovieIntroduceCell else {
                return UICollectionViewCell()
            }
            
            let item = items[indexPath.item]
            cell.setPoster(with: item.posterImage)
            cell.setPoster(with: item.posterName)
            return cell
            
        case let .Genre(items):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieStillCutCell.identifier,
                for: indexPath) as? MovieStillCutCell else {
                return UICollectionViewCell()
            }
            
            let item = items[indexPath.item]
            cell.setGenrePoster(with: item.genreImage)
            return  cell
            
        case let .KoreaBoxOffice(items):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: KoreaBoxOfficeListCell.identifier,
                for: indexPath) as? KoreaBoxOfficeListCell else {
                return UICollectionViewCell()
            }
            
            let item = items[indexPath.item]
            cell.rankView.setRank(by: item.rank)
            cell.rankView.setRankVariation(by: item.rankVariation)
            cell.rankView.setRankVariation(by: UIColor.black)
            
            cell.rankView.setRankImage(by: UIImage(named: "Suzume"))
            cell.rankView.setRankImage(by: UIColor.black)
            
            cell.summaryInformationView.setMovieName(by: item.movieName)
            cell.summaryInformationView.setAudienceCount(by: item.audienceCount)
            return  cell
        }
    }
}
