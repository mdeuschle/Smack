//
//  SocketService.swift
//  Smack
//
//  Created by Matt Deuschle on 9/18/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let shared = SocketService()

    override init() {
        super.init()
    }

    var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: URLString.url.rawValue)!)

    func establishConnection() {
        socket.connect()
    }

    func closeConnection() {
        socket.disconnect()
    }

    func addChannel(channelName: String, channelDescription: String, completion: @escaping Completion) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }

    func getChannel(completion: @escaping Completion) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelID = dataArray[2] as? String else { return }

            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelID)
            ChannelService.shared.channels.append(newChannel)
            completion(true)
        }
    }

    func addMessage(messageBody: String, userID: String, channelID: String, completion: @escaping Completion) {
        let user = UserDataService.shared
        socket.emit("newMessage", messageBody, userID, channelID, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
}












