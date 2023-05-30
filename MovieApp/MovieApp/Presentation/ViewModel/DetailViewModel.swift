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
            let aaa = await loadSelectedMovieDetailInformation(movieCode: movieCode)
            print(aaa)
            
            let bbb = await loadMovieCast(movieCode: movieCode)
            print(bbb)
        }
    }
    
    func loadNeedTotMovieDetailSection(movieCode: String) async {
        
        await withTaskGroup(of: MovieInformation.self) { taskGroup in
            taskGroup.addTask { [self] in
                
                let movieInformation = await loadSelectedMovieDetailInformation(movieCode: movieCode)
                let movieCastGroup = await loadMovieCast(movieCode: movieCode)
                
            }
        }
        
    }
}

//MARK: - [Private Method]
extension DetailViewModel {
    
    private func loadSelectedMovieDetailInformation(
        movieCode: String) async -> MovieInformation {
        
        var movieInformation: MovieInformation
        
        do {
            let networkResult = try await self.detailLoader.loadMovieDetailInformation(movieCode: movieCode)
            
            movieInformation = try convertToMovieInformation(from: networkResult)
        } catch {
            print(DetailViewModelInError.failOfLoadMovieInformation)
        }
        
        return movieInformation
    }
    
    private func loadMovieCast(movieCode: String) async -> [MovieCast] {
        
        var movieCastGroup: [MovieCast]
        
        do {
            let networkResult = try await detailLoader.loadMovieCredit(movieCode: movieCode)
            
            let castGroup = try convertToMovieCast(from: networkResult)
            
            let imagePathGroup = castGroup.map { cast in
                if let imagePath = cast.profilePath {
                    return imagePath
                }
                return ""
            }
            
            
            
        } catch {
            print(DetailViewModelInError.failOfLoadMovieCast)
        }
        
        return movieCastGroup
    }
    
    //TODO: - HomeViewModel과 동일한 메서드로 중복 제거 요망
    private func fetchImage(imagePath: String) async throws -> Data {
        
        let imageURLPath = "\(TMDBBasic.imageURL)\(imagePath)"
        
        guard let imageURL = URL(string: imageURLPath) else {
            throw HomeViewModelInError.failOfMakeURL
        }
            
        guard let imageData = try? Data(contentsOf: imageURL) else {
            throw HomeViewModelInError.failOfMakeData
        }
        
        return imageData
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
