//
//  KakaoBasic.swift
//  MovieApp
//
//  Created by Jason on 2023/05/22.
//

import Foundation

enum KakaoBasic {
    // https://dapi.kakao.com/v2/search/image?query=스즈메의문단속
    static let baseURL: String = "https://dapi.kakao.com/v2/search/image"
    static let query: String = "query"
    static let page: String = "page"
    static let size: String = "size"
    
    static let headers: [String: String] = [
        "Authorization":"KakaoAK fa7f07de12d5091df52431ed3f1c700d"
    ]
}
