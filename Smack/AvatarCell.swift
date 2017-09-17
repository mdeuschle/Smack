//
//  AvatarCell.swift
//  Smack
//
//  Created by Matt Deuschle on 9/17/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {

    @IBOutlet var avatarImageCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpAvatarCell()
    }

    func setUpAvatarCell() {
        layer.cornerRadius = 5.0
        layer.backgroundColor = UIColor.lightGray.cgColor
        clipsToBounds = true
    }
    
}
