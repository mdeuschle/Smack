//
//  ProfileVC.swift
//  Smack
//
//  Created by Matt Deuschle on 9/17/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        displayUser()

    }

    func displayUser() {
        profileImageView.image = UIImage(named: UserDataService.shared.avatarName)
        nameLabel.text = UserDataService.shared.name
        emailLabel.text = UserDataService.shared.email
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.dismissView))
        backgroundView.addGestureRecognizer(tap)
    }

    func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func logoutTapped(_ sender: UIButton) {
        UserDataService.shared.logoutUser()
        NotificationCenter.default.post(name: NotifUserDataDidChange, object: nil)
        dismiss(animated: true, completion: nil)
    }
}
