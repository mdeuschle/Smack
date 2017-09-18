//
//  MessageCell.swift
//  Smack
//
//  Created by Matt Deuschle on 9/18/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            layer.backgroundColor = UIColor(white: 1.0, alpha: 0.2).cgColor
        } else {
            layer.backgroundColor = UIColor.clear.cgColor
        }
    }

    func configChannelCell(channel: Channel) {
        let title = channel.channelTitle ?? ""
        messageLabel.text = "#" + title
    }

}
