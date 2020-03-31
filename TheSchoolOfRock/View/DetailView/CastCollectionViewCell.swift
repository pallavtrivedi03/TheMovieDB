//
//  CastCollectionViewCell.swift
//  TheSchoolOfRock
//
//  Created by Pallav Trivedi on 29/03/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castTitleLabel: UILabel!
    @IBOutlet weak var castImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        castImageView.clipsToBounds = true
        castImageView.layer.masksToBounds = true
        castImageView.layer.cornerRadius = 12
    }
}
