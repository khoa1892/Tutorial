//
//  AppNavigationDrawerController.swift
//  MaterialDesignTut
//
//  Created by Khoa on 11/23/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import Material

class AppNavigationDrawerController: NavigationDrawerController {

    open override func prepare() {
        super.prepare()
        statusBarStyle = .default
    }
}
