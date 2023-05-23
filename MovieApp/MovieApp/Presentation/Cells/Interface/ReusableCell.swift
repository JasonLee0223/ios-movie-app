//
//  ReusableCell.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
