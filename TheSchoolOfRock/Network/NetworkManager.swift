//
//  NetworkManager.swift
//  TheSchoolOfRock
//
//  Created by Pallav Trivedi on 28/03/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    let webserviceHelper = WebserviceHelper()
    
    private init() { }
    
    func getMovies(page: Int, completion: @escaping (TrendingMoviesResponse?) -> ()) {
        
        guard let url = addQueryParams(urlString: AppConstants.API.trendingMovies, params: [URLQueryItem(name: "api_key", value: AppConstants.API.key), URLQueryItem(name: "page", value: "\(page)")]) else {
            return
        }
        
        webserviceHelper.fetchResponse(url: url, shouldCancelOtherOps: true) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(nil)
            } else {
                let jsonDecoder = JSONDecoder()
                do {
                    let trendingMoviesResponse = try jsonDecoder.decode(TrendingMoviesResponse.self, from: data!)
                    completion(trendingMoviesResponse)
                } catch {
                    print("Error occured while parsing trending movies response")
                    completion(nil)
                }
            }
        }
    }
    
    func getReviews(id: String, completion: @escaping () -> ()) {
        
    }
    
    func getCast(id: String, completion: @escaping (CastResponse?) -> ()) {
        guard let url = addQueryParams(urlString: AppConstants.API.credits.replacingOccurrences(of: "{id}", with: id), params: [URLQueryItem(name: "api_key", value: AppConstants.API.key)]) else {
            return
        }
        
        webserviceHelper.fetchResponse(url: url, shouldCancelOtherOps: false) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(nil)
            } else {
                let jsonDecoder = JSONDecoder()
                do {
                    let castResponse = try jsonDecoder.decode(CastResponse.self, from: data!)
                    completion(castResponse)
                } catch {
                    print("Error occured while parsing cast response")
                    completion(nil)
                }
            }
        }
    }
    
    func getSimilar(id: String, completion: @escaping (SimilarMovieResponse?) -> ()) {
        guard let url = addQueryParams(urlString: AppConstants.API.similar.replacingOccurrences(of: "{id}", with: id), params: [URLQueryItem(name: "api_key", value: AppConstants.API.key)]) else {
            return
        }
        
        webserviceHelper.fetchResponse(url: url, shouldCancelOtherOps: false) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(nil)
            } else {
                let jsonDecoder = JSONDecoder()
                do {
                    let similarResponse = try jsonDecoder.decode(SimilarMovieResponse.self, from: data!)
                    completion(similarResponse)
                } catch {
                    print("Error occured while parsing similar response")
                    completion(nil)
                }
            }
        }
    }
    
    func addQueryParams(urlString: String, params: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = params
        return urlComponents?.url
    }
}
