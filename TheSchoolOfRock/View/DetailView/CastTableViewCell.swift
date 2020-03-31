//
//  CastTableViewCell.swift
//  TheSchoolOfRock
//
//  Created by Pallav Trivedi on 29/03/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    enum CellType {
        case cast
        case similar
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    var cast: [Cast]?
    var similar: [SimilarMovie]?
    var cellType: CellType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.register(UINib(nibName: AppConstants.ViewIdentifiers.castCollectionCell, bundle: nil), forCellWithReuseIdentifier: AppConstants.ViewIdentifiers.castCollectionCell)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CastTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cellType == CellType.cast {
            return cast?.count ?? 0
        } else {
            return similar?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellType! {
        case .cast:
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.ViewIdentifiers.castCollectionCell, for: indexPath) as? CastCollectionViewCell
                 var posterUrl = AppConstants.API.imageBasePath.appending(AppConstants.API.posterSize)
                 posterUrl = posterUrl.appending(cast?[indexPath.row].profile_path ?? "")
                 cell?.castImageView.kf.setImage(with: URL(string: posterUrl))
                 cell?.castTitleLabel.text = cast?[indexPath.row].name ?? ""
                 return cell!
        case .similar:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.ViewIdentifiers.castCollectionCell, for: indexPath) as? CastCollectionViewCell
            var posterUrl = AppConstants.API.imageBasePath.appending(AppConstants.API.posterSize)
            posterUrl = posterUrl.appending(similar?[indexPath.row].poster_path ?? "")
            cell?.castImageView.kf.setImage(with: URL(string: posterUrl))
            cell?.castTitleLabel.text = similar?[indexPath.row].title ?? ""
            return cell!
        }
     
    }
    
    
}

extension CastTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 87, height: 164)
    }
}
