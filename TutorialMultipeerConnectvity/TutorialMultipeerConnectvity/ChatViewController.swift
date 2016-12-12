//
//  ChatViewController.swift
//  TutorialMultipeerConnectvity
//
//  Created by Khoa on 10/26/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var messageArray: [Dictionary<String, String>] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.handleMPCReceivedDataWithNotification(notification:)), name: NSNotification.Name(rawValue: "receivedMPCDataNotification"), object: nil)
        let barButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ChatViewController.endChat(sender:)))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func endChat(sender: UIBarButtonItem) {
        let messageDictionary: [String: String] = ["message": "_end_chat_"]
        if appDelegate.mpcManager.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.mpcManager.session.connectedPeers[0]) {
            self.dismiss(animated: true, completion: { 
                self.appDelegate.mpcManager.session.disconnect()
            })
        }
    }
    
    func handleMPCReceivedDataWithNotification(notification: Notification) {
        let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
        let data = receivedDataDictionary["data"] as? Data
        let fromPeer = receivedDataDictionary["fromPeer"] as! MCPeerID
        let dataDictionary = NSKeyedUnarchiver.unarchiveObject(with: data!) as! Dictionary<String, String>
        if let message = dataDictionary["message"] {
            if message != "_end_Chat_"{
                let messageDictionary: [String: String] = ["sender": fromPeer.displayName, "message": message]
                messageArray.append(messageDictionary)
                OperationQueue.main.addOperation({ 
                    self.updateTableView()
                })
            }
        } else {
            let alertVC = UIAlertController(title: "", message: "\(fromPeer.displayName) end chat", preferredStyle: UIAlertControllerStyle.alert)
            let doneAction = UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (alertAction) in
                self.appDelegate.mpcManager.session.disconnect()
                self.dismiss(animated: true, completion: nil)
            })
            alertVC.addAction(doneAction)
            OperationQueue.main.addOperation({ 
                self.present(alertVC, animated: true, completion: nil)
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let messageDictionary: [String: String] = ["message": textField.text!]
        if appDelegate.mpcManager.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.mpcManager.session.connectedPeers[0]) {
            let dictionary: [String: String] = ["sender": "self", "message": textField.text!]
            messageArray.append(dictionary)
            self.updateTableView()
        } else {
            print("could not send data")
        }
        textField.text = ""
        return true
    }
    func updateTableView() {
        self.tableView.reloadData()
        if self.tableView.contentSize.height > self.tableView.frame.size.height {
            self.tableView.scrollToRow(at: NSIndexPath(row: messageArray.count - 1, section: 0) as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let currentMessage = messageArray[indexPath.row] as Dictionary<String, String>
        if let sender = currentMessage["sender"] {
            var senderLabelText: String
            var senderColor: UIColor
            if sender == "self" {
                senderLabelText = "I said:"
                senderColor = UIColor.yellow
            } else {
                senderLabelText = sender + "said:"
                senderColor = UIColor.orange
            }
            cell.detailTextLabel?.text = senderLabelText
            cell.detailTextLabel?.textColor = senderColor
        }
        if let message = currentMessage["message"] {
            cell.textLabel?.text = message
        }
        return cell
    }
}
