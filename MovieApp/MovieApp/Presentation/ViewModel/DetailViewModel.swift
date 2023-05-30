//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

final class DetailViewModel {
    
    //MARK: - Initializer
    var sectionStroage: [DetailSectionList: Observable<DetailEntityWrapper>]
    
    init() {
        self.detailLoader = DetailLoader()
        
        sectionStroage = [.movieDetailInformationSection: Observable<DetailEntityWrapper>(),
                          .movieOfficialsSection: Observable<DetailEntityWrapper>()]
    }
    
    //MARK: - Private Property

    private let detailLoader: DetailLoader
}

//MARK: - [Public Method] Use of MovieDetailViewController
extension DetailViewModel {
    
    func loadNeedTotMovieDetailSection(movieCode: String) async {
        //TODO: - If need to switch-case sectionType make this mehtod
        
        Task {
            guard let movieInformation = await self.loadSelectedMovieDetailInformation(movieCode: movieCode) else {
                return
            }
            let movieInformationWrapper = DetailEntityWrapper.movieDetailInformation(movieInformation)
            
            sectionStroage[.movieDetailInformationSection]?.value = [movieInformationWrapper]
        }
        
        Task {
            let moiveCastGroup = await loadMovieCast(movieCode: movieCode)
            let moiveCastWrapper = moiveCastGroup.map { movieCast in
                DetailEntityWrapper.movieCast(movieCast)
            }
            sectionStroage[.movieOfficialsSection]?.value = moiveCastWrapper
        }
    }
}

//MARK: - [Private Method] Use at internal ViewModel
extension DetailViewModel {
    
    func loadSelectedMovieDetailInformation(movieCode: String) async -> MovieInformation? {
        
        do {
            let networkResult = try await self.detailLoader.loadMovieDetailInformation(movieCode: movieCode)
            let movieInformation = try detailLoader.convertToMovieInformation(from: networkResult)
            return movieInformation
        } catch {
            print(DetailViewModelInError.failOfLoadMovieInformation)
            return nil
        }
    }
    
    func loadMovieCast(movieCode: String) async -> [MovieCast] {
        
        var movieCastGroup = [MovieCast]()
        
        do {
            let networkResult = try await detailLoader.loadMovieCredit(movieCode: movieCode)
            
            let castGroup = try convertToMovieCast(from: networkResult)
            
            for cast in castGroup {
                
                guard let imagePath = cast.profilePath else {
                    throw DetailViewModelInError.failOfUnwrapping
                }
                let imageData = try detailLoader.fetchImage(imagePath: imagePath)
                
                let movieCast = MovieCast(
                    identifier: UUID(),
                    castInformation: CastInformation(originalName: cast.name,
                                                     character: cast.character, job: cast.job),
                    peopleImage: imageData)
                movieCastGroup.append(movieCast)
            }
        } catch {
            print(DetailViewModelInError.failOfLoadMovieCast)
        }
        
        return movieCastGroup
    }
}

//MARK: - [Private Method] Help Method
extension DetailViewModel {
    
    private func convertToMovieCast(from networkResult: TMDBMovieCredit) throws -> [Cast] {
        
        let actorGroup = networkResult.cast
        var director = networkResult.crew.filter {
            $0.department == "Directing" && $0.job == "Director"
        }
        
        var usableCastGroup = [Cast]()
        
        for index in 0..<9 {
            usableCastGroup.append(actorGroup[index])
        }
        usableCastGroup.append(director.removeFirst())
        
        return usableCastGroup
    }
}
