//
//  ChatVC.swift
//  Smack
//
//  Created by Matt Deuschle on 9/8/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var chatTextField: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.estimatedRowHeight = 80
        messageTableView.rowHeight = UITableViewAutomaticDimension
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())

        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange), name: NotifUserDataDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NotifChannelSelected, object: nil)

        if AuthService.shared.isLoggedIn {
            AuthService.shared.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NotifUserDataDidChange, object: nil)
            })
        }
    }

    @objc func handleTap() {
        view.endEditing(true)
    }

    @objc func userDataDidChange(_ notification: Notification) {
        if AuthService.shared.isLoggedIn {
            onLoginGetMessage()
        } else {
            titleLabel.text = "Please Login"
        }
    }

    @objc func channelSelected(_ notification: Notification) {
        updateWithChannel()
    }

    func updateWithChannel() {
        let channelName = ChannelService.shared.selectedChannel?.channelTitle ?? ""
        titleLabel.text = "#\(channelName)"
        getMessages()
    }

    func onLoginGetMessage() {
        ChannelService.shared.getChannelData { (success) in
            if success {
                if ChannelService.shared.channels.isEmpty {
                    self.titleLabel.text = "No channels yet"
                } else {
                    ChannelService.shared.selectedChannel = ChannelService.shared.channels[0]
                    self.updateWithChannel()
                }
            }
        }
    }

    func getMessages() {
        guard let channelID = ChannelService.shared.selectedChannel?.id else { return }
        ChannelService.shared.getAllMessagesForChannel(channelID: channelID) { (success) in
            if success {
                print("MESSAGES: \(ChannelService.shared.messages)")

                self.messageTableView.reloadData()
            } else {
                print("No success")
            }
        }
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        if AuthService.shared.isLoggedIn {
            guard let channelID = ChannelService.shared.selectedChannel?.id else { return }
            guard let message = chatTextField.text else { return }

            SocketService.shared.addMessage(messageBody: message, userID: UserDataService.shared.id, channelID: channelID, completion: { (success) in
                if success {
                    self.chatTextField.text = ""
                    self.chatTextField.resignFirstResponder()
                }
            })
        }
    }
}


extension ChatVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChannelService.shared.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableCell.messageCell.rawValue, for: indexPath) as? MsgCell else {
            return MsgCell()
        }
        let message = ChannelService.shared.messages[indexPath.row]
        cell.config(message: message)
        return cell
    }
}











