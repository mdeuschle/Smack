//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Matt Deuschle on 9/8/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func unwindToChannelVC(_ sender: Any) {
        performSegue(withIdentifier: SegueString.toChannelVC.rawValue, sender: nil)
    }
}
