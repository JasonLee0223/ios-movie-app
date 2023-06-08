//
//  DetailSection.swift
//  MovieApp
//
//  Created by Jason on 2023/05/31.
//

import Foundation

struct DetailSection: Hashable {
    var type: DetailSectionList
    var items: [DetailEntityWrapper]
}
