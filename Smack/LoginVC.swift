//
//  LoginVC.swift
//  Smack
//
//  Created by Matt Deuschle on 9/8/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func dontHaveAccountTapped(_ sender: UIButton) {
        performSegue(withIdentifier: SegueString.toCreateAccount.rawValue, sender: nil)
    }

}
