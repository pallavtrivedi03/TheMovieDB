//
//  PosterTableViewCell.swift
//  TheSchoolOfRock
//
//  Created by Pallav Trivedi on 29/03/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import UIKit

class PosterTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.clipsToBounds = true
        posterImageView.layer.masksToBounds = true
        posterImageView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
