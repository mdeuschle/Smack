//
//  RoundedButton.swift
//  Smack
//
//  Created by Matt Deuschle on 9/16/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

@IBDesignable

class RoundedButton: UIButton {

    @IBInspectable var corderRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = corderRadius
        }
    }

    override func awakeFromNib() {
        self.setUpView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUpView()
    }

    func setUpView() {
        self.layer.cornerRadius = corderRadius
    }
}
