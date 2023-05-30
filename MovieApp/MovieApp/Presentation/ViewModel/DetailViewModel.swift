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

//MARK: - [Public Method] Use of MovieDetailViewController
extension DetailViewModel {
    
    func loadAllOfMovieDetailNeedData(movieCode: String) {
        
        Task {
            let aaa = try await loadSelectedMovieDetailInformation(movieCode: movieCode)
            print(aaa)
            
            let bbb = try await loadMovieCast(movieCode: movieCode)
            print(bbb)
        }
    }
}

//MARK: - [Private Method]
extension DetailViewModel {
    
    private func loadSelectedMovieDetailInformation(
        movieCode: String) async throws -> MovieInformation {
        
        var movieInformation: MovieInformation
        
        do {
            let networkResult = try await self.detailLoader.loadMovieDetailInformation(movieCode: movieCode)
            
            movieInformation = try convertToMovieInformation(from: networkResult)
        } catch {
            throw DetailViewModelInError.failOfLoadMovieInformation
        }
        
        return movieInformation
    }
    
    private func loadMovieCast(movieCode: String) async throws -> [MovieCast] {
        
        var movieCastGroup: [MovieCast]
        
        do {
            let networkResult = try await detailLoader.loadMovieCredit(movieCode: movieCode)
            
            movieCastGroup = try convertToMovieCast(from: networkResult)
            
        } catch {
            throw DetailViewModelInError.failOfLoadMovieCast
        }
        
        return movieCastGroup
    }
}

//MARK: - [Private Method] Help Method
extension DetailViewModel {
    
    private func convertToMovieInformation(
        from networkResult: TMDBMovieDetail) throws -> MovieInformation {
            
            let wrappingMovieInformation: MovieInformation?
        
            var watchGrade: String = ""
            
            let nations = networkResult.productionCountries.map { countriesInfo in
                countriesInfo.name
            }
            
            let genres = networkResult.genres.map { genre in
                genre.name
            }
            
            if !networkResult.adult {
                watchGrade = "전체 이용가"
            }
            
            wrappingMovieInformation = MovieInformation(
                identifier: UUID(),
                movieSummary: MovieSummary(
                    watchGrade: watchGrade,
                    movieKoreanName: networkResult.koreanTitle,
                    movieEnglishName: networkResult.movieEnglishTitle
                ),
                
                nations: nations,
                genres: genres,
                
                subInformation: SubInformation(
                    releaseDate: networkResult.releaseDate,
                    runtime: String(networkResult.runtime),
                    overview: networkResult.overview
                )
            )
            
            guard let movieInformation = wrappingMovieInformation else {
                throw DetailViewModelInError.failOfUnWrapping
            }
            return movieInformation
    }
    
    private func convertToMovieCast(from networkResult: TMDBMovieCredit) throws -> [MovieCast] {
        
        let actorGroup = networkResult.cast
        var director = networkResult.crew.filter {
            $0.department == "Directing" && $0.job == "Director"
        }
        
        var usableCastGroup = [Cast]()
        
        for index in 0..<9 {
            usableCastGroup.append(actorGroup[index])
        }
        usableCastGroup.append(director.removeFirst())
        
        let movieCastGroup = usableCastGroup.map { cast in
            MovieCast(
                castInformation: CastInformation(
                    originalName: cast.name,
                    profilePPath: cast.profilePath,
                    character: cast.character
                ),
                job: cast.job
            )
        }
        return movieCastGroup
    }
}
