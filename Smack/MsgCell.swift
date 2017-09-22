//
//  MsgCell.swift
//  Smack
//
//  Created by Matt Deuschle on 9/21/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class MsgCell: UITableViewCell {

    @IBOutlet var userImage: CircleView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var timeStampLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(message: Message) {
        messageLabel.text = message.message
        usernameLabel.text = message.userName
        userImage.image = UIImage(named: message.userAvatar)
    }

}
