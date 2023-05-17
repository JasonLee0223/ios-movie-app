//
//  Staff.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct Staff: Decodable {
    let peopleName: String
    let peopleNameInEnglish: String
    let staffRoleName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameInEnglish = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
