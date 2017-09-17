//
//  CircleView.swift
//  Smack
//
//  Created by Matt Deuschle on 9/17/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIImageView {

    override func awakeFromNib() {
        setUpView()
    }

    func setUpView() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
}
