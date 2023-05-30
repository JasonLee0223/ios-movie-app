//
//  BusinessModel.swift
//  MovieApp
//
//  Created by Jason on 2023/05/30.
//

import Foundation

protocol BusinessModel: Hashable {
    var identifier: UUID { get }
}
