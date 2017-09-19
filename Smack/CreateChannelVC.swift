//
//  CreateChannelVC.swift
//  Smack
//
//  Created by Matt Deuschle on 9/18/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class CreateChannelVC: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var userNameTestField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateChannelVC.dismissKeyboard))
        backgroundView.addGestureRecognizer(tap)
    }

    func dismissKeyboard(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createChannelTapped(_ sender: UIButton) {
        if AuthService.shared.isLoggedIn {
            guard let channelName = userNameTestField.text, userNameTestField.text != "" else { return }
            guard let channelDesc = descriptionTextField.text else { return }
            SocketService.shared.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}














