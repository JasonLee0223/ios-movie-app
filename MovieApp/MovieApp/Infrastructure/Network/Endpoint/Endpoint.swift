//
//  Endpoint.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

protocol RequestAndResponsable: Requestable, Responsable { }

final class EndPoint<R>: RequestAndResponsable {
    typealias Responese = R

    var baseURL: String
    var firstPath: String
    var secondPath: String
    var method: HTTPMethodType
    var queryParameters: Encodable?

    init(baseURL: String, firstPath: String, secondPath: String, method: HTTPMethodType = .get, queryParameters: Encodable? = nil) {
        self.baseURL = baseURL
        self.firstPath = firstPath
        self.secondPath = secondPath
        self.method = method
        self.queryParameters = queryParameters
    }

}

enum HTTPMethodType: String {
    case get = "GET"
}
