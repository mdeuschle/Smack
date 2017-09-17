//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Matt Deuschle on 9/8/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {


    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var profileImageView: UIImageView!

    var avatarName = "defaultName"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.shared.avatarName != "" {
            profileImageView.image = UIImage(named: UserDataService.shared.avatarName)
            avatarName = UserDataService.shared.avatarName
        }
    }

    @IBAction func unwindToChannelVC(_ sender: Any) {
        performSegue(withIdentifier: SegueString.toChannelVC.rawValue, sender: nil)
    }

    @IBAction func chooseAvatarTapped(_ sender: UIButton) {
        performSegue(withIdentifier: SegueString.toAvatarPicker.rawValue, sender: nil)
    }

    @IBAction func generateBackgroundColorTapped(_ sender: UIButton) {
    }

    @IBAction func signupButtonTapped(_ sender: UIButton) {

        guard let email = emailTextField.text, emailTextField.text != nil else {
            return
        }
        guard let password = passwordTextField.text, passwordTextField.text != nil else {
            return
        }

        guard let name = userNameTextField.text, userNameTextField.text != nil else {
            return
        }

        AuthService.shared.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.shared.loginUser(email: email, password: password) { (success) in
                    if success {
                        AuthService.shared.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor) { (success) in
                            if success {
                                print("NAME: \(UserDataService.shared.name), COLOR: \(UserDataService.shared.avatarColor)")
                                self.performSegue(withIdentifier: SegueString.toChannelVC.rawValue, sender: nil)
                            }
                        }
                    }
                }
            }
        }




    }


    
}
