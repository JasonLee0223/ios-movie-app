//
//  NetworkService.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

final class NetworkService {

    //MARK: - Initializer
    
    init() {
        self.session = URLSession(configuration: .default)
    }
    
    //MARK: - Private Property

    private let session: URLSession
}

//MARK: - [Public Method] Use of CompletionHandler
extension NetworkService {
    
    
    
    /// KoreaBoxOfficeMovieList
    func loadKoreaBoxOfficeMovieListData() async throws -> [DailyBoxOfficeList] {
        let yesterdayDate = Getter.receiveCurrentDate.split(separator: "-").joined()
        let boxOfficeQueryParameters = BoxOfficeQueryParameters(targetDate: yesterdayDate)
        
        guard let networkResult = try? await request(
            with: KOFICAPIEndPoint.receiveBoxOffice(
                with: boxOfficeQueryParameters)
        ).boxOfficeResult.dailyBoxOfficeList else {
            throw DataLoadError.failOfkoreaBoxOfficeMovieListData
        }
        
        return networkResult
    }
    
    func loadMovieDetailData(movieCodeGroup: [String]) async throws -> [MovieInfo] {
        
        let movieDetailQueryParametersGroup = movieCodeGroup.map { movieCode in
            MovieDetailQueryParameters(movieCode: movieCode)
        }
        
        var networkResult = [MovieInfo]()
        for movieDetailQueryParameters in movieDetailQueryParametersGroup {
            
            do {
                let result = try await request(
                    with: KOFICAPIEndPoint.receiveMovieDetailInformation(
                    with: movieDetailQueryParameters)
                ).movieInfoResult.movieInfo
                networkResult.append(result)
            } catch {
                throw DataLoadError.failOfMovieDetailInfromationData
            }
        }
            
        return networkResult
    }
}

//MARK: - [Public Method] Use of CompletionHandler
extension NetworkService {
    
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
    
    /// KoreaBoxOfficeMovieList
    func loadDailyBoxOfficeData(completion: @escaping ([DailyBoxOfficeList]) -> Void) {
        
        Task {
            let yesterdayDate = Getter.receiveCurrentDate.split(separator: "-").joined()
            let boxOfficeQueryParameters = BoxOfficeQueryParameters(targetDate: yesterdayDate)
            let swapResult = try await request(
                with: KOFICAPIEndPoint.receiveBoxOffice(
                    with: boxOfficeQueryParameters)
            ).boxOfficeResult.dailyBoxOfficeList
            
            completion(swapResult)
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
}

//MARK: - Private Method
extension NetworkService {
    
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
