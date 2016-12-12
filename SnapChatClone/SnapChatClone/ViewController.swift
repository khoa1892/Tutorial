//
//  ViewController.swift
//  SnapChatClone
//
//  Created by Khoa on 11/11/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: AAPLCameraViewController, AAPLCameraVCDelegate {

    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var previewView: AAPLPreviewView!
    var videoURL: URL?
    override func viewDidLoad() {
        delegate = self
        self._previewView = previewView
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        guard FIRAuth.auth()?.currentUser != nil, FIRAuth.auth()?.currentUser?.displayName == "Mai Đăng Khoa" else {
//            performSegue(withIdentifier: "LoginVC", sender: nil)
//            return
//        }
//        self.performSegue(withIdentifier: "LoginVC", sender: nil)
        
    }

    @IBAction func recordBtnPressed(_ sender: Any) {
        if FIRAuth.auth()?.currentUser == nil || FIRAuth.auth()?.currentUser?.displayName == "Mai Đăng Khoa" {
            self.performSegue(withIdentifier: "LoginVC", sender: nil)
        }else {
            toggleMovieRecording()
        }
    }
    
    @IBAction func changeCameraBtnPressed(_ sender: Any) {
        changeCamera()
    }
    
    func shouldEnableRecordUI(_ enable: Bool) {
        self.recordBtn.isEnabled = enable
        print("Should enable record UI: \(enable)")
    }
    
    func shouldEnableCameraUI(_ enable: Bool) {
        self.cameraBtn.isEnabled = enable
        print("Should enable camera UI: \(enable)")
    }
    
    func canStartRecording() {
        print("Recording has started")
    }
    
    func recordingHasStarted() {
        print("Can start recording")
    }
    
    func videoRecordingComplete(_ videoURL: URL) {
        performSegue(withIdentifier: "UsersVC", sender: ["videoURL": videoURL])
    }
    
    func videoRecordingFailed() {
        
    }
    
    func snapshotTaken(_ snapShotData: Data) {
        performSegue(withIdentifier: "UsersVC", sender: ["snapShotData": snapShotData])
    }
    
    func snapshotFailed() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let userVC = segue.destination as? UsersVC {
            if let videoDict = sender as? [String: URL] {
                let url = videoDict["videoURL"]
                userVC.videoURL = url
            } else if let imageDict = sender as? [String: Data] {
                let snapData = imageDict["snapShotData"]
                userVC.snapData = snapData
            }
        }
    }
    
}

