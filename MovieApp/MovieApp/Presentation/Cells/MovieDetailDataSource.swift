//
//  MovieDetailDataSource.swift
//  MovieApp
//
//  Created by Jason on 2023/05/29.
//

import UIKit

final class MovieDetailDataSource: NSObject, UICollectionViewDataSource {
    
    let mockData: [MockSection] = [.movieDetail(
        [.init(image: UIImage(named: "Suzume") ?? UIImage(),
               grade: "관람 등급",
               moiveName: "스즈메의 문단속",
               movieEnName: "Suzume of locking door",
               movieSummary: "개봉일, 국가, 장르, 상영시간",
               overview: "죽을 위기에서 살아난 존 윅은 최고 회의를 쓰러트릴 방법을 찾아낸다. 비로소 완전한 자유의 희망을 보지만, 빌런 그라몽 후작과 전 세계의 최강 연합은 존 윅의 오랜 친구까지 적으로 만들어 버리고, 새로운 위기에 놓인 존 윅은 최후의 반격을 준비하는데..."
              )
        ]), .movieOfficial(
            .init(
                repeating: .init(
                    image: UIImage(systemName: "Star.fill") ?? UIImage(),
                    title: "인물 이름",
                    distance: "역할"),
                count: 10)),
        .audienceCount([.init()])]
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        DetailSectionList.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch mockData[section] {
        case let .movieDetail(items):
            return items.count
        case let .movieOfficial(items):
            return items.count
        case let .audienceCount(items):
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: DetailHeaderView.reuseIdentifier,
                for: indexPath) as? DetailHeaderView else {
                return UICollectionReusableView()
            }
            
            let sectionType = DetailSectionList.allCases[indexPath.section]
            switch sectionType {
            case .movieDetailInformationSection:
                print("첫번째 Section은 HeaderView 없음")
            case .movieOfficialsSection:
                headerView.configureOfMovieOfficialsLayout()
            case .audienceCountSection:
                headerView.configureOfaudienceCountLayout()
            }
            
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch mockData[indexPath.section] {
        case let .movieDetail(items):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieDetailInformationCell.reuseIdentifier,
                for: indexPath
            ) as? MovieDetailInformationCell else {
                return UICollectionViewCell()
            }
            let item = items[indexPath.item]
            
            cell.setPosterImage(by: item.image)
            
            let mockTexts = [item.grade,
                             item.moiveName,
                             item.movieEnName,
                             item.movieSummary]
            
            cell.setMovieSummaryInfo(by: mockTexts)
            
            cell.setOverView(by: item.overview)
            
            return cell
        case let .movieOfficial(items):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieOfficialsCell.reuseIdentifier,
                for: indexPath) as? MovieOfficialsCell else {
                return UICollectionViewCell()
            }
            let item = items[indexPath.item]
            cell.setPeopleName(by: item.title)
            cell.setRole(by: item.distance)
            
            return cell
        case .audienceCount(_):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AudienceCountCell.reuseIdentifier,
                for: indexPath) as? AudienceCountCell else {
                return UICollectionViewCell()
            }
            
            return cell
        }
    }
    
    
}

enum MockSection {
    case movieDetail([movieDetailItem])
    case movieOfficial([movieOfficialItem])
    case audienceCount([audienceCountItem])
    
    struct movieDetailItem {
        let image: UIImage
        let grade: String
        let moiveName: String
        let movieEnName: String
        let movieSummary: String
        let overview: String
    }
    
    struct movieOfficialItem {
        let image: UIImage
        let title: String
        let distance: String
    }
    
    struct audienceCountItem {
        
    }
}

