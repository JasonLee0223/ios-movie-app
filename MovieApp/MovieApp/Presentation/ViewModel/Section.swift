//
//  Section.swift
//  MovieApp
//
//  Created by Jason on 2023/05/26.
//

import Foundation

struct Section: Hashable {
    var type: SectionList
    var items: [BusinessModelWrapper]
}
