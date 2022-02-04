//
//  Movie.swift
//  Movie Search
//
//  Created by Carlotta Chen on 2/4/22.
//

import Foundation

struct Movie: Decodable {
    let results: [MovieObj]
}

struct MovieObj: Decodable {
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let voteAverage: Float
    
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}


