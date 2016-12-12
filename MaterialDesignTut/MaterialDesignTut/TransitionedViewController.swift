//
//  TransitionedViewController.swift
//  MaterialDesignTut
//
//  Created by Khoa on 11/23/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import Material

class TransitionedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.purple.base
        self.prepareToolbar()
    }
    
    private func prepareToolbar() {
        guard let tc = toolbarController else {
            return
        }
        tc.toolbar.title = "Transitioned"
        tc.toolbar.detail = "View Controller"
    }

}
