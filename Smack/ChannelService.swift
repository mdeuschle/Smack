//
//  ChannelService.swift
//  Smack
//
//  Created by Matt Deuschle on 9/18/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ChannelService {

    static let shared = ChannelService()
    var selectedChannel: Channel?
    var channels = [Channel]()
    var messages = [Message]()

    func getChannelData(completion: @escaping Completion) {
        Alamofire.request(URLString.urlGetChannel.rawValue, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: bearerHeader).responseJSON { (response) in
            if response.result.error == nil {
                guard let jsonData = response.data else { return }
                if let json = JSON(data: jsonData).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let description = item["descriptin"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: description, id: id)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NotifChannelsLoaded, object: nil)
                    completion(true)
                }

            } else {
                completion(false)
                print(response.result.error as Any)
            }
        }
    }

    func getAllMessagesForChannel(channelID: String, completion: @escaping Completion) {
        Alamofire.request("\(URLString.urlGetMessage.rawValue)\(channelID)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: bearerHeader).responseJSON { (response) in
            if response.result.error == nil {
                self.removeAllMessages()
                guard let data = response.data else { return }
                if let json = JSON(data: data).array {
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                        let channelID = item["channelID"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        let message = Message(message: messageBody,
                                              userName: userName,
                                              channelID: channelID,
                                              userAvatar: userAvatar,
                                              id: id,
                                              timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                    print("MESSAGES: \(self.messages)")
                    completion(true)
                }
            } else {
                print("MESSAGE ERROR: \(response.result.error as Any)")
                completion(false)
            }
        }
    }

    func removeAllChannels() {
        channels.removeAll()
    }

    func removeAllMessages() {
        messages.removeAll()
    }
}










