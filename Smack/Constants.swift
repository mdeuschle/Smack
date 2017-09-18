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
let bearerHeader = ["Authorization": "Bearer \(AuthService.shared.token)",
    "Content-Type": "application/json; charset=utf-8"]
let PlaceholderColor = #colorLiteral(red: 0.3492529392, green: 0.7451983094, blue: 0.7409211397, alpha: 0.4654467282)
let NotifUserDataDidChange = Notification.Name("notUserDataDidChange")

enum SegueString: String {
    case toLogin = "toLogin"
    case toCreateAccount = "toCreateAccount"
    case toChannelVC = "toChannelVC"
    case toAvatarPicker = "toAvatarPicker"
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
    case urlUserAdd = "https://chattyslackapp.herokuapp.com/v1/user/add"
    case urlUserByEmil = "https://chattyslackapp.herokuapp.com/v1/user/byEmail/"
    case urlGetChannel = "https://chattyslackapp.herokuapp.com/v1/channel"
}

enum ReusableCell: String {
    case avatarCell = "AvatarCell"
}
