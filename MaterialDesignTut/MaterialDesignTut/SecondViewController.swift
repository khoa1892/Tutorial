//
//  SecondViewController.swift
//  MaterialDesignTut
//
//  Created by Khoa on 11/23/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import Material

class SecondViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareToolbar()
    }
    
    private func prepareToolbar() {
        guard let tc = toolbarController else {
            return
        }
        tc.toolbar.title = "Second"
        tc.toolbar.detail = "Second View Controller"
    }

}
