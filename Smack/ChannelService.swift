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
    func removeAllChannels() {
        channels.removeAll()
    }
}
