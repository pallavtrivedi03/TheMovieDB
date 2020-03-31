//
//  AppConstants.swift
//  TheSchoolOfRock
//
//  Created by Pallav Trivedi on 28/03/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation

struct AppConstants {
    struct API {
        static let key                      = "9bbcc9729b78405065442ee2adc7cac9"
        static let trendingMovies           = "https://api.themoviedb.org/3/movie/now_playing"
        static let imageBasePath            = "https://image.tmdb.org/t/p/"
        static let reviews                  = "https://api.themoviedb.org/3/movie/{id}/reviews"
        static let credits                  = "https://api.themoviedb.org/3/movie/{id}/credits"
        static let similar                  = "https://api.themoviedb.org/3/movie/{id}/similar"
        static let posterSize               = "w342"
        
    }
    
    struct ViewIdentifiers {
        static let movieCell            = "MovieTableViewCell"
        static let detailView           = "DetailViewController"
        static let posterViewCell       = "PosterTableViewCell"
        static let sysnopsisCell        = "SynopsisTableViewCell"
        static let castCell             = "CastTableViewCell"
        static let castCollectionCell   = "CastCollectionViewCell"
    }
}
