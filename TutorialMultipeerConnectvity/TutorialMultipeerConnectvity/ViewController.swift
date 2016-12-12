//
//  ViewController.swift
//  TutorialMultipeerConnectvity
//
//  Created by Khoa on 10/26/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MPCManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblPeers: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var isAdvertising: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        appDelegate.mpcManager.delegate = self
        tblPeers.dataSource = self
        tblPeers.delegate = self
        appDelegate.mpcManager.browser.startBrowsingForPeers()
        self.isAdvertising = true
        
    }
    func foundPeer() {
        tblPeers.reloadData()
    }
    func lostPeer() {
        tblPeers.reloadData()
    }
    func invitationWasReceived(fromPeer: String) {
        let alert = UIAlertController(title: "", message: "\(fromPeer) want to chat with you", preferredStyle: UIAlertControllerStyle.alert)
        let acceptAction = UIAlertAction(title: "Accept", style: UIAlertActionStyle.default) { (alertAction) in
            self.appDelegate.mpcManager.invitationHandler(true, self.appDelegate.mpcManager.session)
        }
        let declineAction = UIAlertAction(title: "Decline", style: UIAlertActionStyle.cancel) { (alertAction) in
            self.appDelegate.mpcManager.invitationHandler(true, nil)
        }
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        OperationQueue.main.addOperation {
            self.present(alert, animated: true, completion: nil)
        }
    }
    func connectedWithPeer(peerID: MCPeerID) {
        OperationQueue.main.addOperation { 
            self.performSegue(withIdentifier: "idSegueChat", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.mpcManager.foundPeers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = appDelegate.mpcManager.foundPeers[indexPath.row].displayName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPeer = appDelegate.mpcManager.foundPeers[indexPath.row] as MCPeerID
        appDelegate.mpcManager.browser.invitePeer(selectedPeer, to: appDelegate.mpcManager.session, withContext: nil, timeout: 20)
    }
    
    @IBAction func startStopAdvertising(sender: UIBarButtonItem!) {
        let actionSheet = UIAlertController(title: "", message: "Change Visibility", preferredStyle: UIAlertControllerStyle.actionSheet)
        var actionTitle: String
        if isAdvertising == true {
            actionTitle = "Make me invisible to others"
        } else {
            actionTitle = "make me visble to others"
        }
        let visibleAction: UIAlertAction = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default) { (alertAction) in
            if self.isAdvertising == true {
                self.appDelegate.mpcManager.advertiser.stopAdvertisingPeer()
            } else {
                self.appDelegate.mpcManager.advertiser.startAdvertisingPeer()
            }
            self.isAdvertising = !self.isAdvertising
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        actionSheet.addAction(visibleAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

