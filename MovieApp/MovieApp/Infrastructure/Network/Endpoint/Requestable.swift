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
}

extension Requestable {

    func receiveURLRequest() throws -> URLRequest {
        let url = try url()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }

    func url() throws -> URL {
        let fullPath = "\(baseURL)\(firstPath)\(secondPath ?? "")\(KOFICBasic.format)"

        guard var urlComponents = URLComponents(string: fullPath) else {
            throw URLComponentsError.invalidComponent
        }

        var urlQueryItems = [URLQueryItem]()

        if let queryParameters = try queryParameters?.toDictionary() {
            let sortedQueryParameters = queryParameters.sorted { (first, second) in
                return first.key < second.key
            }

            sortedQueryParameters.forEach {
                urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
            }
        }

        guard !urlQueryItems.isEmpty else {
            throw URLComponentsError.invalidComponent
        }

        urlComponents.queryItems = urlQueryItems

        guard let url = urlComponents.url else {
            throw URLComponentsError.invalidComponent
        }

        return url
    }
}

extension Encodable {
    func toDictionary() throws -> [String: Any]? {

        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}
