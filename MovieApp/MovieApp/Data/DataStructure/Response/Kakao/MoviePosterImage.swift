//
//  MoviePosterImage.swift
//  MovieApp
//
//  Created by Jason on 2023/05/22.
//

import Foundation


struct MoviePosterImage {
    let documents: [Document]
}

struct Document {
    let imageURL: String
    let thumbnailURL: String
}
