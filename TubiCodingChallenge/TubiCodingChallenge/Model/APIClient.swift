//
//  APIClient.swift
//  TubiCodingChallenge
//
//  Created by Mitali Kulkarni on 4/19/19.
//  Copyright © 2019 Mitali Kulkarni. All rights reserved.
//

import Foundation

class APIClient {
    static let base = "https://us-central1-modern-venture-600.cloudfunctions.net/api/movies"
    static var cache = LRUCache<String, MovieDetails>(5)
    
    enum Endpoints {
        case getMovieList
        case getMovieDetails(String)
        case movieImagePath(String)
        
        var stringValue: String {
            switch self {
            case .getMovieList:
                return base
            case .getMovieDetails(let id):
                return base + "/\(id)"
            case .movieImagePath(let movieImagePath):
                return "\(movieImagePath)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    // MARK: - GET Request
    @discardableResult class func taskForGETRequest<ResponseType: Decodable> (url: URL, response: ResponseType.Type, completionHandler: @escaping(ResponseType?, Error?) -> Void) -> URLSessionTask {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            }
        }
        task.resume()
        
        return task
    }
    
    // MARK: - GetMovieList
    class func getMovieList(completion: @escaping ([Movie], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getMovieList.url, response: [Movie].self) { (response, error) in
            if let response = response {
                completion(response, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    // MARK: - GET Movie image
    class func downloadPosterImage(imagePath: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        let newTask = URLSession.shared.dataTask(with: Endpoints.movieImagePath(imagePath).url, completionHandler: { (data1, response1, error1) in
            guard let imageDownloaded = data1 else {
                completionHandler(nil, error1)
                return
            }
            DispatchQueue.main.async {
                completionHandler(imageDownloaded, nil)
            }
        })
        newTask.resume()
    }
    
    // MARK: - GET Movie Details
    class func getMovieDetails(key: String, completion: @escaping (MovieDetails?, Error?) -> Void) {
        // Check if the cache has the Movie Details
        if (cache.isValid(key)) {
            if let movieDetails: MovieDetails = cache.get(key) {
                completion(movieDetails, nil)
            }
        } else {
            taskForGETRequest(url: Endpoints.getMovieDetails(key).url, response: MovieDetails.self) { (response, error) in
                if let response = response {
                    cache.add(key, response)
                    completion(response, nil)
                } else {
                    completion(nil, error)
                }
            }
        }
    }
}
