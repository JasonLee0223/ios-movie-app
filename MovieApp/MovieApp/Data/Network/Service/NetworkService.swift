//
//  NetworkService.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation
import Alamofire

final class NetworkService: Gettable {

    //MARK: - Initializer
    
    init() {
        self.session = URLSession(configuration: .default)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            self.loadBoxOffice { result in
                print(result)
            }
        }
    }
    
    //MARK: - Private Property

    private let session: URLSession
}

//MARK: - [Private Method] Configure of Service (URLResponse, Decoding)
extension NetworkService {
    
    func loadBoxOffice(completionHandler: @escaping ([DailyBoxOfficeList]) -> Void) {
        guard let url = URL(string: KOFICBasic.baseURL + Show.boxOffice + Show.searchDailyList + KOFICBasic.format) else { return }
        let parameters = BoxOfficeQueryParameters(key: getAPIKEY(type: .KOFIC), targetDate: getCurrentDate().split(separator: "-").joined())
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(BoxOffice.self, from: data)
                    completionHandler(result.boxOfficeResult.dailyBoxOfficeList)
                } catch {
                    print(DataLoadError.loadFailOfBoxOfficeList)
                }
            case .failure(let error):
                switch error {
                case .sessionTaskFailed(let sessionError):
                    print("Session Error: \(sessionError)")
                case .createURLRequestFailed(let urlRequestError):
                    print("URLRequest Error: \(urlRequestError)")
                default:
                    print(error)
                }
            }
        }
    }
    
    func request<R: Decodable, E: RequestAndResponsable>(with endPoint: E) async throws -> R where E.Responese == R {
        
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
