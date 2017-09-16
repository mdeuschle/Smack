//
//  AuthService.swift
//  Smack
//
//  Created by Matt Deuschle on 9/16/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {

    static let shared = AuthService()

    let defaults = UserDefaults.standard

    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: AuthKey.isLoggedIn.rawValue)
        } set {
            defaults.set(newValue, forKey: AuthKey.isLoggedIn.rawValue)
        }
    }

    var email: String {
        get {
            return defaults.value(forKey: AuthKey.email.rawValue) as! String
        } set {
            defaults.set(newValue, forKey: AuthKey.email.rawValue)
        }
    }

    var token: String {
        get {
            return defaults.value(forKey: AuthKey.token.rawValue) as! String
        } set {
            defaults.set(newValue, forKey: AuthKey.token.rawValue)
        }
    }

    func createUsers(email: String, password: String, completion: @escaping Completion) {

        let lowerEmail = email.lowercased()

        let header = ["Content-Type": "application/json; charset=utf-8"]

        let body = ["email": lowerEmail,
                        "password": password]

        Alamofire.request(URLString.urlRegister.rawValue, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                print(response.result.error as Any)
            }
        }






    }
}





