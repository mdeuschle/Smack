//
//  AvatarCell.swift
//  Smack
//
//  Created by Matt Deuschle on 9/17/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

enum AvatarType {
    case light
    case dark
}

class AvatarCell: UICollectionViewCell {

    @IBOutlet var avatarImageCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpAvatarCell()
    }

    func configCell(avatarType: AvatarType, index: Int) {
        if avatarType == AvatarType.dark {
            avatarImageCell.image = UIImage(named: "dark\(index)")
            layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImageCell.image = UIImage(named: "light\(index)")
            layer.backgroundColor = UIColor.gray.cgColor
        }
    }

    func setUpAvatarCell() {
        layer.cornerRadius = 5.0
        layer.backgroundColor = UIColor.lightGray.cgColor
        clipsToBounds = true
    }
    
}
