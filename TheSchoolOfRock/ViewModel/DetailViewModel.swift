//
//  DetailViewModel.swift
//  TheSchoolOfRock
//
//  Created by Pallav Trivedi on 29/03/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    var movie: Movie?
    var cast: CastResponse? {
        didSet {
            if let reloadBlock = self.reloadTableData {
                reloadBlock()
            }
        }
    }
    
    var similar: SimilarMovieResponse? {
        didSet {
            if let reloadBlock = self.reloadTableData {
                reloadBlock()
            }
        }
    }
    
    var reloadTableData : (() -> Void)? = nil

    var rows = [0: AppConstants.ViewIdentifiers.posterViewCell, 1: AppConstants.ViewIdentifiers.sysnopsisCell]
    
    func fetchCast() {
        guard let id = movie?.id else { return }
        weak var weakSelf = self
        NetworkManager.shared.getCast(id: "\(id)") { (castResponse) in
            weakSelf?.rows[2] = AppConstants.ViewIdentifiers.castCell
            weakSelf?.cast = castResponse
            
        }
    }
    
    func fetchSimilar() {
        guard let id = movie?.id else { return }
        weak var weakSelf = self
        NetworkManager.shared.getSimilar(id: "\(id)") { (similarResponse) in
            weakSelf?.rows[3] = AppConstants.ViewIdentifiers.castCell
            weakSelf?.similar = similarResponse
            
        }
    }
}
