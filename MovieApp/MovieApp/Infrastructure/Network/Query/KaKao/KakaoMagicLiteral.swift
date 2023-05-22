//
//  KakaoMagicLiteral.swift
//  MovieApp
//
//  Created by Jason on 2023/05/22.
//

import Foundation

enum KakaoMagicLiteral {
    static let baseURL: String = "https://dapi.kakao.com/v2/search"
    static let image: String = "/image"
    static let query: String = "query"
    static let authorization: String = "Authorization"
    static let kakaoRESTAPIKey: String = "KakaoAK \(kakaoApiKey)"
    private static let kakaoApiKey: String = getRESTAPIKEY()
    
    private static func getRESTAPIKEY() -> String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "KakaoRESTAPIKEY") as? String else {
            return ""
        }
        return apiKey
    }
}
