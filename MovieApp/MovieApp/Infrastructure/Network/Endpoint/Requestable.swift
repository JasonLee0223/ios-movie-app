//
//  Requestable.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

protocol Requestable {
    var baseURL: String { get }
    var firstPath: String { get }
    var secondPath: String? { get }
    var method: HTTPMethodType { get }
    var queryParameters: Encodable? { get }
    var headers: [String: String]? { get }
}

extension Requestable {

    func receiveURLRequest<E: RequestAndResponsable>(by endPoint: E) throws -> URLRequest {
        
        guard let fullPath = try decide(toType: endPoint) else {
            throw URLComponentsError.invalidComponent
        }
        
        let url = try makeURL(by: fullPath)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        headers?.forEach({ (key: String, value: String) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        })

        return urlRequest
    }
    
    private func makeURL(by fullPath: String) throws -> URL {
        
        var urlComponents = try verify(by: fullPath)
        
        var urlQueryItems = [URLQueryItem]()
        
        if let queryParameters = try queryParameters?.toDictionary() {
            queryParameters.forEach {
                urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
            }
        }
        urlComponents.queryItems = urlQueryItems

        guard let url = urlComponents.url else {
            throw URLComponentsError.invalidComponent
        }
        
        return url
    }
    
    private func verify(by fullPath: String) throws -> URLComponents {
        guard let urlComponents = URLComponents(string: fullPath) else {
            throw URLComponentsError.invalidComponent
        }
        return urlComponents
    }
    
    private func decide<E: RequestAndResponsable>(toType endPoint: E) throws -> String? {
        if endPoint is EndPoint<TMDBTrendMovieList> {
            return "\(baseURL)\(firstPath)"
        }
        
        if endPoint is EndPoint<BoxOffice> ||
           endPoint is EndPoint<MovieDetailInformation> {
            return "\(baseURL)\(firstPath)\(secondPath ?? "")\(KOFICBasic.format)"
        }
        
        if endPoint is EndPoint<MoviePosterImage> {
            return "\(baseURL)\(firstPath)"
        }
        return nil
    }
}

extension Encodable {
    func toDictionary() throws -> [String: Any]? {

        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}
