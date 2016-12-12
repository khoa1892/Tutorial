//
//  DataService.swift
//  SnapChatClone
//
//  Created by Khoa on 11/16/16.
//  Copyright © 2016 Khoa. All rights reserved.
//
let FIR_CHILD_USERS = "users"

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DataService {
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    var mainRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var usersRef: FIRDatabaseReference {
        return mainRef.child(FIR_CHILD_USERS)
    }
    
    var mainStorage: FIRStorageReference {
        return FIRStorage.storage().reference(forURL: "gs://devchat-c90b7.appspot.com/")
    }
    
    var imageStorageRef: FIRStorageReference {
        return mainStorage.child("images")
    }
    
    var videoStorageRef: FIRStorageReference {
        return mainStorage.child("videos")
    }
    
    func saveUser(uid: String) {
        let profile:[String: Any] = ["firstName": "", "lastName": ""]
        mainRef.child(FIR_CHILD_USERS).child(uid).child("profile").setValue(profile)
    }
    
    func sendMediaPullRequest(senderUID: String, sendingTo: [String: User], mediaURL: URL, textSnippet: String? = nil) {
        var uids = [String]()
        for uid in sendingTo.keys {
            uids.append(uid)
        }
        let pr: [String: Any] = ["mediaURL": mediaURL.absoluteString, "userID": senderUID, "openCount": 0, "recipients": uids]
        
        mainRef.child("pullRequests").childByAutoId().setValue(pr)
        
    }
    
}
