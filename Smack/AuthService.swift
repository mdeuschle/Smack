//
//  AuthService.swift
//  Smack
//
//  Created by Matt Deuschle on 9/16/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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

    func registerUser(email: String, password: String, completion: @escaping Completion) {

        let lowerEmail = email.lowercased()

        let body = ["email": lowerEmail,
                    "password": password]

        Alamofire.request(URLString.urlRegister.rawValue, method: .post, parameters: body, encoding: JSONEncoding.default, headers: Header).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                print(response.result.error as Any)
            }
        }
    }

    func loginUser(email: String, password: String, completion: @escaping Completion) {

        let lowerEmail = email.lowercased()

        let body = ["email": lowerEmail,
                    "password": password]

        Alamofire.request(URLString.urlLogin.rawValue, method: .post, parameters: body, encoding: JSONEncoding.default, headers: Header).responseJSON { (response) in
            if response.result.error == nil {

                guard let data = response.data else {
                    return
                }

                let json = JSON(data: data)
                self.email = json["user"].stringValue
                self.token = json["token"].stringValue

                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                print(response.result.error as Any)
            }
        }
    }

    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping Completion) {

        let lowerEmail = email.lowercased()

        let body: [String: Any] = ["name": name,
                                   "email": lowerEmail,
                                   "avatarName": avatarName,
                                   "avatarColor": avatarColor]

        let header = ["Authorization": "Bearer \(AuthService.shared.token)",
            "Content-Type": "application/json; charset=utf-8"]

        Alamofire.request(URLString.urlUserAdd.rawValue, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {

                guard let data = response.data else {
                    return
                }
                let json = JSON(data: data)
                let id = json["_id"].stringValue
                let color = json["avatarColor"].stringValue
                let avatarName = json["avatarName"].stringValue
                let email = json["email"].stringValue
                let name = json["name"].stringValue

                UserDataService.shared.setUserData(id: id, avatarColor: color, avatarName: avatarName, email: email, name: name)

                completion(true)

            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
}





