//
//  AppToolbarController.swift
//  MaterialDesignTut
//
//  Created by Khoa on 11/23/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import Material

class AppToolbarController: ToolbarController {

    private var menuButton: IconButton!
    private var startButton: IconButton!
    private var searchButton: IconButton!

    open override func prepare() {
        super.prepare()
        self.prepareMenuButton()
        self.prepareStartButton()
        self.prepareSearchButton()
        self.prepareStatusBar()
        self.prepareToolbar()
    }

    func handleMenuButton() {
        self.navigationDrawerController?.toggleLeftView()
    }
    
    private func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu, tintColor: .white)
        menuButton.pulseColor = .white
        self.menuButton.addTarget(self, action: #selector(AppToolbarController.handleMenuButton), for: UIControlEvents.touchUpInside)
    }
    
    private func prepareStartButton() {
        startButton = IconButton(image: Icon.cm.star, tintColor: .white)
        menuButton.pulseColor = .white
    }
    
    private func prepareSearchButton() {
        searchButton = IconButton(image: Icon.cm.search, tintColor: .white)
        searchButton.pulseColor = .white
    }
    
    private func prepareStatusBar() {
        statusBarStyle = .lightContent
        statusBar.backgroundColor = Color.red.darken3
    }
    
    private func prepareToolbar() {
        toolbar.backgroundColor = Color.red.darken2
        toolbar.leftViews = [menuButton]
        toolbar.rightViews = [startButton, searchButton]
    }
}
