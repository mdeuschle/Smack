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

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func unwindToChannelVC(_ sender: Any) {
        performSegue(withIdentifier: SegueString.toChannelVC.rawValue, sender: nil)
    }

    @IBAction func chooseAvatarTapped(_ sender: UIButton) {
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

        AuthService.shared.createUsers(email: email, password: password) { (success) in
            if success {
                AuthService.shared.loginUser(email: email, password: password) { (loginSuccess) in
                    if loginSuccess {
                        print("LOGIN SUCCESS! \(AuthService.shared.token)")
                    }
                }
            }
        }




    }


    
}
