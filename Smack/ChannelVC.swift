//
//  ChannelVC.swift
//  Smack
//
//  Created by Matt Deuschle on 9/8/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet var channelTableView: UITableView!
    @IBOutlet var profileImage: CircleView!
    @IBOutlet var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        channelTableView.delegate = self
        channelTableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userUpdated(_:)), name: NotifUserDataDidChange, object: nil)
        SocketService.shared.getChannel { (success) in
            if success {
                self.channelTableView.reloadData()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        setUpUserInfo()
    }

    func userUpdated(_ notification: Notification) {
        setUpUserInfo()
    }

    func setUpUserInfo() {
        if AuthService.shared.isLoggedIn {
            loginButton.setTitle(UserDataService.shared.name, for: .normal)
            profileImage.image = UIImage(named: UserDataService.shared.avatarName)
        } else {
            loginButton.setTitle("Login", for: .normal)
            profileImage.image = #imageLiteral(resourceName: "menuProfileIcon")
            profileImage.backgroundColor = UIColor.clear
        }
    }

    @IBAction func unwindeToChannelVC(segue: UIStoryboardSegue){}

    @IBAction func addChannelTapped(_ sender: UIButton) {
        let createChannelVC = CreateChannelVC()
        createChannelVC.modalPresentationStyle = .custom
        present(createChannelVC, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if AuthService.shared.isLoggedIn {
            let profileVC = ProfileVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: SegueString.toLogin.rawValue, sender: nil)
        }
    }
}

extension ChannelVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChannelService.shared.channels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableCell.channelCell.rawValue) as? MessageCell else {
            return MessageCell()
        }
        let message = ChannelService.shared.channels[indexPath.row]
        cell.configChannelCell(channel: message)
        return cell
    }

}











