//
//  CollectionDataProvider.swift
//  MovieApp
//
//  Created by Jason on 2023/05/23.
//

import Foundation

public protocol CollectionDataProvider {
    associatedtype T

    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> T?

    func updateItem(at indexPath: IndexPath, value: T)
}
