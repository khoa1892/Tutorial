//
//  UsersCell.swift
//  SnapChatClone
//
//  Created by Khoa on 11/16/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit

class UsersCell: UITableViewCell {

    @IBOutlet weak var firtNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setCheckmark(selected: false)
    }
    
    func updateUI(user: User) {
        firtNameLabel.text = user.uid
    }

    func setCheckmark(selected: Bool) {
        let imageStr = selected ? "messageindicatorchecked1" : "messageindicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imageStr))
    }

}
