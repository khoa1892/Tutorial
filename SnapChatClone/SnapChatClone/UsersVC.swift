//
//  UsersVC.swift
//  SnapChatClone
//
//  Created by Khoa on 11/16/16.
//  Copyright © 2016 Khoa. All rights reserved.
//



import UIKit
import FirebaseDatabase
import FirebaseAuth

class UsersVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    private var users = [User]()
    private var selectedUser = [String: User]()
    private var _snapData: Data?
    private var _videoURL: URL?
    
    var snapData: Data? {
        set {
            _snapData = newValue
        }
        get {
            return _snapData
        }
    }
    
    var videoURL: URL? {
        set {
            _videoURL = newValue
        }
        get {
            return _videoURL
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsMultipleSelection = true
        
        DataService.instance.usersRef.observeSingleEvent(of: FIRDataEventType.value) { (snapShot: FIRDataSnapshot) in
            if let users = snapShot.value as? [String: Any] {
                for (key, value) in users {
                    if let dict = value as? [String: Any] {
                        if let profile = dict["profile"] as? [String: Any] {
                            if let firstName = profile["firstName"] as? String {
                                let uid = key
                                let user = User(uid: uid, firstName: firstName)
                                self.users.append(user)
                            }
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UsersCell
        let user = self.users[indexPath.row]
        cell.updateUI(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        let cell = tableView.cellForRow(at: indexPath) as! UsersCell
        cell.setCheckmark(selected: true)
        let user = self.users[indexPath.row]
        self.selectedUser[user.uid] = user
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UsersCell
        cell.setCheckmark(selected: false)
        let user = self.users[indexPath.row]
        self.selectedUser[user.uid] = nil
        if self.selectedUser.count <= 0 {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }

    @IBAction func sendPRBtnPressed(_ sender: Any) {
        if let url = _videoURL {

            let videoName = "\(NSUUID().uuidString)\(url)"
            let ref = DataService.instance.videoStorageRef.child(videoName)
            _ = ref.putFile(url, metadata: nil, completion: { (metaData, error) in
                if error != nil {
                    print("Error uploading video \(error?.localizedDescription)")
                } else {
                    let downloadURL = metaData?.downloadURL()
                    DataService.instance.sendMediaPullRequest(senderUID: (FIRAuth.auth()?.currentUser?.uid)!, sendingTo: self.selectedUser, mediaURL: downloadURL!, textSnippet: "coding Today")
                    print("Download URL: \(downloadURL)")
                    // save this somewhere
                }
                self.dismiss(animated: true, completion: nil)
            })
        } else if let imageData = _snapData {
            let ref = DataService.instance.imageStorageRef.child("\(NSUUID().uuidString).jpg")
            _ = ref.put(imageData, metadata: nil, completion: { (metaData, error) in
                if error != nil {
                    print("Error uploading image \(error?.localizedDescription)")
                } else {
                    let downloadURL = metaData?.downloadURL()
                    print("Download URL: \(downloadURL)")
                    
                }
                self.dismiss(animated: true, completion: nil)
            })
        }
        
    }
}
