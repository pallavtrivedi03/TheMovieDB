//
//  HomeViewModel.swift
//  TheSchoolOfRock
//
//  Created by Pallav Trivedi on 28/03/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    var movies = [Movie]() {
        didSet {
            if let reloadBlock = self.reloadTableData {
                reloadBlock()
            }
        }
    }
    
    var filteredMovies = [Movie]() {
        didSet {
            if let reloadBlock = self.reloadTableData {
                reloadBlock()
            }
        }
    }
    
    var currentPage = 0
    var totalPages = 0
    
    var reloadTableData : (() -> Void)? = nil
    
    func fetchTrendingMovies() {
        weak var weakSelf = self
        if currentPage <= totalPages {
            currentPage = currentPage.advanced(by: 1)
            
            NetworkManager.shared.getMovies(page: currentPage) { (trendingMoviesResponse) in
                if let moviesResponse = trendingMoviesResponse {
                    weakSelf?.totalPages = moviesResponse.total_pages ?? 0
                    if let movies = moviesResponse.results {
                        weakSelf?.movies.append(contentsOf: movies)
                        weakSelf?.filteredMovies = (weakSelf?.movies)!
                        
                    }
                }
            }
        }
        
    }
    
    func searchMovie(queryString: String) {
        
        filteredMovies = movies
        
        if queryString == "" {
            filteredMovies = movies
        } else {
            var searchedMovies = [Movie]()
            var rankings = [Movie: Int]()
            for movie in filteredMovies {
                if !queryString.contains(" ") {
                    var words = [String]()
                    if movie.title?.contains(" ") ?? false {
                        words = (movie.title?.components(separatedBy: " "))!
                    } else {
                        words.append(movie.title ?? "")
                    }
                    words = words.map{$0.lowercased()}
                    for (index,word) in words.enumerated() {
                        if let range = word.range(of: queryString) {
                            let startPos = word.distance(from: word.startIndex, to: range.lowerBound)
                            if startPos == 0 {
                                rankings[movie] = index+1
                                break
                            }
                        }
                    }
                } else {
                    if movie.title?.lowercased().contains(queryString) ?? false {
                        rankings[movie] = 1
                    }
                }
            }
            for (key,_) in rankings.sorted(by: {$0.1 < $1.1}) {
                searchedMovies.append(key)
            }
            filteredMovies = searchedMovies
        }
    }
    
    
}
