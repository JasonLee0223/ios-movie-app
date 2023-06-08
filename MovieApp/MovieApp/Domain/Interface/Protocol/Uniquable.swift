//
//  Uniquable.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

protocol BusinessModel: Uniquable, Hashable { }

protocol Uniquable {
    var identifier: UUID { get }
}

extension Uniquable {
    var identifier: UUID {
        return UUID()
    }
}
