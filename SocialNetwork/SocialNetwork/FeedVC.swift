//
//  FeedVC.swift
//  SocialNetwork
//
//  Created by Khoa on 11/8/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PostCellDelegate {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageAdd: CircleView!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var postTextField: FancyField!
    
    static var imgCache: NSCache<NSString, UIImage> = NSCache()
    var posts = [Post]()
//    var arrCache = [UIImage]()
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    var username: String = ""
    var likeCount = 0
    var uid = ""
    
//    func loadArrImage(urlString: String, index: Int) {
//        guard let url:URL = URL(string: urlString) else {return}
//        do {
//            let dataImage:Data = try Data(contentsOf: url)
//            self.arrCache.append(UIImage(data: dataImage)!)
//            self.arrCache[index] = UIImage(data: dataImage)!
//            DispatchQueue.main.async {
//                self.tableView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: UITableViewRowAnimation.automatic)
//            }
//        } catch {}
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.activityIndicator.startAnimating()
        DataServices.ds.REF_POSTS.observe(.value, with: { (snapShot) in
            if let snapShot = snapShot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapShot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? [String: Any] {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                    }
//                    DispatchQueue.main.async {
//                        let queue = DispatchQueue(label: "queue", attributes: DispatchQueue.Attributes.concurrent)
//                        for i in 0..<self.posts.count {
//                            self.arrCache.append(UIImage(named: "placeholder")!)
//                            queue.async {
//                                self.loadArrImage(urlString: self.posts[i].imageUrl, index: i)
//                            }
//                        }
//                        self.tableView.reloadData()
//                        self.activityIndicator.isHidden = true
//                        self.activityIndicator.stopAnimating()
//                    }
                }
            }
        })
        if let username = UserDefaults.standard.string(forKey: "username") {
            self.username = username
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageAdd.image = image
            imageSelected = true
        } else {
            print("Fail")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostCell
        cell.delegate = self
        let item = self.posts[indexPath.row]
        
        cell.postImage.contentMode = .scaleAspectFit
//        cell.postImage.image = arrCache[indexPath.row]
        if let imgCache = FeedVC.imgCache.object(forKey: item.imageUrl as NSString) {
            cell.configureCell(post: item, image: imgCache, index: indexPath)
        } else {
            cell.configureCell(post: item, image: nil, index: indexPath)
        }
        return cell
    }
    @IBAction func postBtnPressed(_ sender: Any) {
        
        
        
        guard let caption = self.postTextField.text, caption != "" else {
            print("Caption must be entered")
            return
        }
        guard let image = self.imageAdd.image, self.imageSelected == true else {
            print("An image must be selected")
            return
        }
        if let imgData = UIImageJPEGRepresentation(image, 0.2) {
            let imgUid = UUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            DataServices.ds.REF_POST_IMAGES.child(imgUid).put(imgData, metadata: metaData, completion: { (metaData, error) in
                if error != nil {
                    print("Unable to upload Image")
                } else {
                    print("Successfully upload Image")
                    let downloadUrl = metaData?.downloadURL()?.absoluteString
                    if  let url = downloadUrl {
                        self.postToFirebase(imageUrl: url)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
        }
    }
    
    func postToFirebase(imageUrl: String) {
        let post: [String: Any] = [
        "caption": self.postTextField.text!,
        "imageUrl": imageUrl,
        "likes": 0
        ]
        let postFirebase = DataServices.ds.REF_POSTS.childByAutoId()
        postFirebase.setValue(post)
        self.postTextField.text = ""
        self.imageSelected = false
        self.imageAdd.image = UIImage(named: "add-image")
    }
    
    @IBAction func signoutBtnPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imagePickerBtnPressed(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - PostCell Delegate
    
    func countLike(like: Int, postKey: String, index: IndexPath) {
        let ref = FIRDatabase.database().reference().child("posts/\(postKey)")
        print(ref.child("likes"))
        ref.updateChildValues(["likes": like])
    }
    
}
