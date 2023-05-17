//
//  URLComponentsError.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

enum URLComponentsError {
    case invalidComponent
}

extension URLComponentsError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString("Component's requirements are not met \(self)", comment: "")
    }
}
