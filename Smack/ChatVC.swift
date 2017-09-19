//
//  ChatVC.swift
//  Smack
//
//  Created by Matt Deuschle on 9/8/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())

        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange), name: NotifUserDataDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NotifChannelSelected, object: nil)

        if AuthService.shared.isLoggedIn {
            AuthService.shared.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NotifUserDataDidChange, object: nil)
            })
        }
    }

    func userDataDidChange(_ notification: Notification) {
        if AuthService.shared.isLoggedIn {
            onLoginGetMessage()
        } else {
            titleLabel.text = "Please Login"
        }
    }

    func channelSelected(_ notification: Notification) {
        updateWithChannel()
    }

    func updateWithChannel() {
        let channelName = ChannelService.shared.selectedChannel?.channelTitle ?? ""
        titleLabel.text = "#\(channelName)"
    }

    func onLoginGetMessage() {
        ChannelService.shared.getChannelData { (success) in
            if success {
                // do stuff with channels
            }
        }
    }
}
