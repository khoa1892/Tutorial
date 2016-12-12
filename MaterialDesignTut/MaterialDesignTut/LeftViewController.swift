//
//  LeftViewController.swift
//  MaterialDesignTut
//
//  Created by Khoa on 11/23/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import Material

class LeftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var transitionButton: FlatButton!
    private var returnBtn: FlatButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = UITableView(frame: UIScreen.main.bounds)
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
//        self.view.backgroundColor = Color.blue.base
//        self.prepareTransitionButton()
//        self.prepareReturnButton()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        if indexPath.row == 0 {
            cell.nameLabel.text = "Home"
        } else if indexPath.row == 1 {
            cell.nameLabel.text = "Trans"
        } else {
            cell.nameLabel.text = "Second"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: ViewController(), completion: closeNavigationDrawer)
        } else if indexPath.row == 1 {
            (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: TransitionedViewController(), completion: closeNavigationDrawer)
        } else {
            (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: SecondViewController(), completion: closeNavigationDrawer)
        }
    }
    
    internal func handleTransitionButton() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: TransitionedViewController(), completion: closeNavigationDrawer)
    }
    
    func handleReturnBtn() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: ViewController(), completion: closeNavigationDrawer)
    }
    
    internal func closeNavigationDrawer(result: Bool) {
        navigationDrawerController?.closeLeftView()
    }
    
    private func prepareReturnButton() {
        self.returnBtn = FlatButton(title: "ViewVC", titleColor: .white)
        self.returnBtn.pulseColor = .white
        self.returnBtn.addTarget(self, action: #selector(LeftViewController.handleReturnBtn), for: UIControlEvents.touchUpInside)
        self.view.layout(self.returnBtn).horizontally().top()
    }
    
    private func prepareTransitionButton() {
        self.transitionButton = FlatButton(title: "Transition VC", titleColor: .white)
        self.transitionButton.pulseColor = .white
        self.transitionButton.addTarget(self, action: #selector(LeftViewController.handleTransitionButton), for: UIControlEvents.touchUpInside)
        self.view.layout(transitionButton).horizontally().center()
    }
    
}
