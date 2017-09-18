//
//  LoginVC.swift
//  Smack
//
//  Created by Matt Deuschle on 9/8/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var spinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

    }

    func setUpView() {
        spinner.isHidden = true
    }

    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func dontHaveAccountTapped(_ sender: UIButton) {
        performSegue(withIdentifier: SegueString.toCreateAccount.rawValue, sender: nil)
    }

    @IBAction func loginTapped(_ sender: RoundedButton) {
        spinner.isHidden = false
        spinner.startAnimating()
        guard let email = usernameTextField.text, usernameTextField.text != "" else { return }
        guard let password = passwordTextField.text, passwordTextField.text != "" else { return }

        AuthService.shared.loginUser(email: email, password: password) { (success) in
            if success {
                AuthService.shared.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NotifUserDataDidChange, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }

    }
}
