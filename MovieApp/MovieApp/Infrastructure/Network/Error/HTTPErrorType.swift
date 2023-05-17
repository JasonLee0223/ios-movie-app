//
//  HTTPErrorType.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

enum HTTPErrorType: Error {
    case redirectionMessages(_ statusCode: Int, _ description: String)
    case clientErrorResponses(_ statusCode: Int, _ description: String)
    case serverErrorResponses(_ statusCode: Int, _ description: String)
    case networkFailError(_ statusCode: Int)
}
