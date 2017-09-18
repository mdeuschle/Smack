//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Matt Deuschle on 9/8/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var profileImageView: UIImageView!

    var avatarName = "defaultName"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var backgroundColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPlaceholder()
    }

    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.shared.avatarName != "" {
            profileImageView.image = UIImage(named: UserDataService.shared.avatarName)
            avatarName = UserDataService.shared.avatarName

            if avatarName.contains("light") && backgroundColor == nil {
                profileImageView.backgroundColor = UIColor.lightGray
            }
        }
    }

    func setUpPlaceholder() {
        spinner.isHidden = true
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSForegroundColorAttributeName : PlaceholderColor])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName : PlaceholderColor])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName : PlaceholderColor])
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func unwindToChannelVC(_ sender: Any) {
        performSegue(withIdentifier: SegueString.toChannelVC.rawValue, sender: nil)
    }

    @IBAction func chooseAvatarTapped(_ sender: UIButton) {
        performSegue(withIdentifier: SegueString.toAvatarPicker.rawValue, sender: nil)
    }

    @IBAction func generateBackgroundColorTapped(_ sender: UIButton) {
        let red = CGFloat(arc4random_uniform(255)) / 255
        let green = CGFloat(arc4random_uniform(255)) / 255
        let blue = CGFloat(arc4random_uniform(255)) / 255
        backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        UIView.animate(withDuration: 0.2) {
            self.profileImageView.backgroundColor = self.backgroundColor
        }
    }

    @IBAction func signupButtonTapped(_ sender: UIButton) {
        spinner.isHidden = false
        spinner.startAnimating()
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
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: SegueString.toChannelVC.rawValue, sender: nil)
                                NotificationCenter.default.post(name: NotifUserDataDidChange, object: nil)
                            }
                        }
                    }
                }
            }
        }
    }
}
