//
//  KakaoBasic.swift
//  MovieApp
//
//  Created by Jason on 2023/05/22.
//

import Foundation

enum KakaoBasic {
    // https://dapi.kakao.com/v2/search/image?query=스즈메의문단속
    static let baseURL: String = KakaoMagicLiteral.baseURL
    static let query: String = KakaoMagicLiteral.query
    
    static let headers: [String: String] = [
        KakaoMagicLiteral.authorization: KakaoMagicLiteral.kakaoRESTAPIKey
    ]
}
