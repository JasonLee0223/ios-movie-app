//
//  Audit.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct Audit: Decodable {
    let auditNumber: String
    let watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}
