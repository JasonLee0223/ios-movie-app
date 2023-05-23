//
//  ConfigurableCell.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

protocol ConfigurableCell: ReusableCell {
    associatedtype T

    func configure(_ item: T, at indexPath: IndexPath)
}
