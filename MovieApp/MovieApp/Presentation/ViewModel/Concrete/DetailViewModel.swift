//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

final class DetailViewModel {
    
    //MARK: - Initializer
    
    init() {
        self.detailLoader = DetailLoader()
    }
    
    //MARK: - Private Property
    
    private let detailLoader: DetailLoader
}

//MARK: - [Private Method] Use at internal ViewModel
extension DetailViewModel {
    
//    func fetchDataAccording(to sectionType: DetailSectionList, and movieCode: String) async -> [DetailEntityWrapper]? {
//        switch sectionType {
//        case .movieDetailInformationSection:
//            guard let information = await loadSelectedMovieDetailInformation(
//                movieCode: movieCode) else { return  nil }
//            return [DetailEntityWrapper.movieDetailInformation(information)]
//        case .movieOfficialsSection:
//            let credits = await loadMovieCast(movieCode: movieCode)
//            return credits.map { cast in
//                DetailEntityWrapper.movieCast(cast)
//            }
//        case .audienceCountSection:
//            return nil
//        }
//    }
    
//    func loadSelectedMovieDetailInformation(movieCode: String) async -> MovieInformation? {
        
//        do {
//            let networkResult = try await self.detailLoader.loadMovieDetailInformation(movieCode: movieCode)
//            let movieInformation = try detailLoader.convertToMovieInformation(from: networkResult)
//            return movieInformation
//        } catch {
//            print(DetailViewModelInError.failOfLoadMovieInformation)
//            return nil
//        }
//    }
    
    func loadMovieCast(movieCode: String) async -> [MovieCast] {
        
        var movieCastGroup = [MovieCast]()
        
//        do {
//            let networkResult = try await detailLoader.loadMovieCredit(movieCode: movieCode)
//
//            let castGroup = try convertToMovieCast(from: networkResult)
//
//            for cast in castGroup {
//
//                guard let imagePath = cast.profilePath else {
//                    throw DetailViewModelInError.failOfUnwrapping
//                }
//                let imageData = try detailLoader.fetchImage(imagePath: imagePath)
//
//                let movieCast = MovieCast(
//                    identifier: UUID(),
//                    castInformation: CastInformation(
//                        originalName: cast.name, character: cast.character, job: cast.job
//                    ),
//                    peopleImage: imageData)
//                movieCastGroup.append(movieCast)
//            }
//        } catch {
//            print(DetailViewModelInError.failOfLoadMovieCast)
//        }
        
        return movieCastGroup
    }
}

//MARK: - [Private Method] Help Method
extension DetailViewModel {
    
    private func convertToMovieCast(from networkResult: TMDBMovieCredit) throws -> [Cast] {
        
        let actorGroup = networkResult.cast
        var director = networkResult.crew.filter {
            $0.job == "Director"
        }
        
        var usableCastGroup = [Cast]()
        
        for index in 0..<9 {
            usableCastGroup.append(actorGroup[index])
        }
        usableCastGroup.append(director.removeFirst())
        
        return usableCastGroup
    }
}
