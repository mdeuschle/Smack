//
//  ChannelVC.swift
//  Smack
//
//  Created by Matt Deuschle on 9/8/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet var profileImage: CircleView!
    @IBOutlet var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userUpdated(_:)), name: NotifUserDataDidChange, object: nil)

    }

    func userUpdated(_ notification: Notification) {
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
