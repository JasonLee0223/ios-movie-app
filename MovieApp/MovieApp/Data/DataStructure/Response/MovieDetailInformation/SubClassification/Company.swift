//
//  Company.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import Foundation

struct Company: Decodable {
    let companyCode: String
    let companyName: String
    let companyNameInEnglish: String
    let companyPartName: String
    
    enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyNameInEnglish = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}
