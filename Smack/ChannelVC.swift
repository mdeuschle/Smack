//
//  ChannelVC.swift
//  Smack
//
//  Created by Matt Deuschle on 9/8/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: SegueString.toLogin.rawValue, sender: nil)
    }
}
