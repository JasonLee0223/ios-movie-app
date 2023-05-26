//
//  NetworkService.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

enum DataLoadError: LocalizedError {
    case failOfkoreaBoxOfficeMovieListData
    case failOfMovieDetailInfromationData
    
    var errorDescription: String? {
        switch self {
        case .failOfkoreaBoxOfficeMovieListData: return "❌ Fail Of KoreaBoxOfficeMovieListData"
        case .failOfMovieDetailInfromationData: return "❌ Fail Of MovieDetailInfromationData"
        }
    }
}

final class NetworkService {

    //MARK: - Initializer
    
    init() {
        self.session = URLSession(configuration: .default)
    }
    
    //MARK: - Method
    
    func loadDailyBoxOfficeData(completion: @escaping ([DailyBoxOfficeList]) -> Void) {
        
        }
    }
    
    func loadMovieDetailData(movieCodeGroup: [String], completion: @escaping (MovieInfo) -> Void) {
        
        movieCodeGroup.forEach { movieCode in
            
            Task {
                let movieDetailQueryParameters = MovieDetailQueryParameters(movieCode: movieCode)
                let networkResult = try await request(
                    with: KOFICAPIEndPoint.receiveMovieDetailInformation(
                        with: movieDetailQueryParameters)
                ).movieInfoResult.movieInfo
                
                completion(networkResult)
            }
        }
    }
    
    func loadTrendingMovieListData(completion: @escaping ([Result]) -> Void) {
        
        Task {
            let popularMovieListQueryParameters = PopularQueryParameters()
            let networkResult = try await request(
                with: TVDBAPIEndPoint.receiveWeakTrendingList(
                    with: popularMovieListQueryParameters)
            ).results
            
            completion(networkResult)
        }
    }
    
    func loadMoviePosterImage(movieNameGroup: [String], completion: @escaping (Document) -> Void) {
        
        movieNameGroup.forEach { movieName in
            
            Task {
                let moviePosterImageParameters = KoreaMovieListImageQueryParameters(query: movieName)
                var networkResult = try await request(
                    with: KakaoEndPoint.receiveMoviePosterImage(
                        with: moviePosterImageParameters)
                ).documents
                
                completion(networkResult.removeFirst())
            }
        }
    }
    
    //MARK: - Private Method

    private func request<R: Decodable, E: RequestAndResponsable>(with endPoint: E) async throws -> R where E.Responese == R {
        
        let urlRequest = try endPoint.receiveURLRequest(by: endPoint)
        
        let (data, response) = try await session.data(for: urlRequest)

        if let identifiedResponse = response as? HTTPURLResponse, !(200...299).contains(identifiedResponse.statusCode) {
            try self.verify(with: identifiedResponse)
        }

        let decodedData: R = try self.decode(with: data)

        return decodedData
    }

    private func verify(with HTTPResponse: HTTPURLResponse) throws {

        switch HTTPResponse.statusCode {
        case (300...399):
            throw HTTPErrorType.redirectionMessages(
                HTTPResponse.statusCode, HTTPResponse.debugDescription
            )
        case (400...499):
            throw HTTPErrorType.clientErrorResponses(
                HTTPResponse.statusCode, HTTPResponse.debugDescription
            )
        case (500...599):
            throw HTTPErrorType.serverErrorResponses(
                HTTPResponse.statusCode, HTTPResponse.debugDescription
            )
        default:
            throw HTTPErrorType.networkFailError(
                HTTPResponse.statusCode
            )
        }
    }

    private func decode<T: Decodable>(with apiData: Data) throws -> T {

        var decode: T
        let decoder = JSONDecoder()

        do {
            decode = try decoder.decode(T.self, from: apiData) as T
        } catch {
            throw NetworkError.decodeError
        }

        return decode
    }
}
