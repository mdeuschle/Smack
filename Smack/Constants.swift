//
//  Constants.swift
//  Smack
//
//  Created by Matt Deuschle on 9/8/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation

typealias Completion = (_ success: Bool) -> ()

let Header = ["Content-Type": "application/json; charset=utf-8"]

enum SegueString: String {
    case toLogin = "toLogin"
    case toCreateAccount = "toCreateAccount"
    case toChannelVC = "toChannelVC"
}

enum AuthKey: String {
    case email = "email"
    case token = "token"
    case isLoggedIn = "isLoggedIn"
}

enum URLString: String {
    case url = "https://chattyslackapp.herokuapp.com/v1/"
    case urlRegister = "https://chattyslackapp.herokuapp.com/v1/account/register"
    case urlLogin = "https://chattyslackapp.herokuapp.com/v1/account/login"
}
