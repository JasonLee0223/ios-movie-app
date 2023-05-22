//
//  MoviePosterImage.swift
//  MovieApp
//
//  Created by Jason on 2023/05/22.
//

import Foundation


struct MoviePosterImage: Decodable {
    let documents: [Document]
}

struct Document: Decodable {
    let imageURL: String
    let thumbnailURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
    }
}
