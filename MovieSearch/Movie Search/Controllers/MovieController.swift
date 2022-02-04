//
//  MovieController.swift
//  Movie Search
//
//  Created by Carlotta Chen on 2/4/22.
//
/*
    GOAL:
 https://api.themoviedb.org/3/search/movie?api_key=990f505d9af8582042975ce901e20651&query={Query}
*/

import UIKit

class MovieController {
    
    static let baseURL = "https://api.themoviedb.org"
    
    static func fetchMovie(query: String, completion: @escaping (Result<[MovieObj], MovieError>) -> Void) {
        
        guard var url = URL(string: baseURL) else { return completion(.failure(.invalidURL)) }
        url.appendPathComponent("3")
        url.appendPathComponent("search")
        url.appendPathComponent("movie")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let api_key = URLQueryItem(name: "api_key", value: "990f505d9af8582042975ce901e20651")
        let query = URLQueryItem(name: "query", value: query)
        components?.queryItems = [api_key, query]
        
        guard let builtURL = components?.url else {
            return completion(.failure(.invalidURL))
        }
        print("Built URL: \(builtURL)")
        
        URLSession.shared.dataTask(with: builtURL) { data, response, error in
            // handle error
            if let e = error {
                return completion(.failure(.thrownError(e)))
            }
            
            // handle response
            if let r = response as? HTTPURLResponse {
                if r.statusCode != 200 {
                    print("MOVIE STATUS CODE: \(r.statusCode)")
                }
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            // decode data
            do {
                let topLvl = try JSONDecoder().decode(Movie.self, from: data)
                let movies = topLvl.results
                
                return completion(.success(movies))
            } catch {
                print("😦\r \(error) \r \(error.localizedDescription) \r")
                return completion(.failure(.unableToDecode))
            }
        
        }.resume()
    }
    
    // fetch image
    static func fetchImage(movie: MovieObj, completion: @escaping (Result<UIImage, MovieError>) -> Void) {

        let imgURL = "https://image.tmdb.org"
        guard let imgPath = movie.posterPath else { return completion(.failure(.invalidURL)) }
        guard var url = URL(string: imgURL) else { return completion(.failure(.invalidURL)) }
        url.appendPathComponent("t")
        url.appendPathComponent("p")
        url.appendPathComponent("w500")
        url.appendPathComponent(imgPath)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // handle error
            if let e = error {
                return completion(.failure(.thrownError(e)))
            }
            
            // handle response
            if let r = response as? HTTPURLResponse {
                if r.statusCode != 200 {
                    print("IMAGE STATUS CODE: \(r.statusCode)")
                }
            }
            
            // decode data
            guard let data = data else { return completion(.failure(.noData)) }
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            return completion(.success(image))
        }.resume()
        
    }
}
