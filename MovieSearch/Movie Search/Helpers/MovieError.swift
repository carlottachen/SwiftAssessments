//
//  MovieError.swift
//  Movie Search
//
//  Created by Carlotta Chen on 2/4/22.
//

import Foundation

enum MovieError: LocalizedError {
case invalidURL
case thrownError(Error) // take in Type Error, not variable
case noData
case unableToDecode

var errorDescription: String? {
    switch self {
    case .invalidURL:
        return "The server failed to reach the URL"
    case .thrownError(let error):
        return "Error: \(error.localizedDescription) -- \(error)"
    case .noData:
        return "The server responded with no data"
    case .unableToDecode:
        return "Unable to decode the data"
    }
}
}
