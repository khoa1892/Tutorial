//
//  PostCell.swift
//  SocialNetwork
//
//  Created by Khoa on 11/9/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import Firebase

protocol PostCellDelegate: NSObjectProtocol {
    func countLike(like: Int, postKey: String, index: IndexPath)
}

class PostCell: UITableViewCell {

    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var imageHeart: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    var post: Post!
    var countLike = 0
    var count = 0
    var delegate: PostCellDelegate?
    var uid = ""
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(post: Post, image: UIImage?, index: IndexPath) {
        self.post = post
        self.caption.text = post.caption
        self.likesLabel.text = "\(post.likes)"
        self.countLike = post.likes
        self.uid = post.postKey
        self.index = index
        if image != nil {
            self.postImage.image = image
        } else {
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Unable to download from Storage Firebase")
                } else {
                    print("Image downladed from Storage Firebase")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImage.image = img
                            FeedVC.imgCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                }
            })
        }
        
    }
    
    @IBAction func likeBtnPressed(_ sender: Any) {
        self.count < 2 ? (self.count = self.count + 1) : (self.count = 1)
        if (self.count == 1) {
            if self.delegate != nil {
                self.heartImage.image = UIImage(named: "filled-heart")
                self.countLike = self.countLike + 1
                if let indexPath = self.index {
                    self.delegate?.countLike(like: self.countLike, postKey: self.uid, index: indexPath)
                }
                
            }
        } else {
            if self.delegate != nil {
                self.heartImage.image = UIImage(named: "empty-heart")
                self.countLike = self.countLike - 1
                if let indexPath = self.index {
                    self.delegate?.countLike(like: self.countLike, postKey: self.uid, index: indexPath)
                }
            }
        }
        
    }
}
