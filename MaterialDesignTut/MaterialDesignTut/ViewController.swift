//
//  ViewController.swift
//  MaterialDesignTut
//
//  Created by Khoa on 11/23/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import Material

struct Button {
    struct Flat {
        static let width:CGFloat = 120
        static let height:CGFloat = 44
        static let offsetY:CGFloat = -150
    }
    struct Raised {
        static let width: CGFloat = 150
        static let height: CGFloat = 44
        static let offsetY: CGFloat = -75
    }
    struct Fab {
        static let diameter:CGFloat = 60
    }
    struct Icon {
        static let width: CGFloat = 120
        static let height: CGFloat = 48
        static let offsetY: CGFloat = 75
    }
    
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    private var nameTextField: TextField!
    private var emailTextField: ErrorTextField!
    private var passwordTextField: TextField!
    
    private let constant: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.grey.lighten5
        self.prepareNameField()
        self.prepareEmailField()
        self.preparePasswordTextField()
        self.prepareFlatButton()
        self.prepareRaisedButton()
        self.prepareFabButton()
        self.prepareToolbar()
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.emailTextField.width = self.view.height - 2 * constant
    }
    
    private func handleResignResponderButton(button: Button) {
        let btn = RaisedButton(title: "Resign", titleColor: Color.blue.base)
        btn.addTarget(self, action: Selector(("handleResignButton:")), for: UIControlEvents.touchUpInside)
    }
    internal func handleResignButton(button: Button) {
        self.nameTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    private func prepareFlatButton(){
        let button = FlatButton(title: "Flat Button")
        self.view.layout(button).width(Button.Flat.width).height(Button.Flat.height).center(offsetY: Button.Flat.offsetY + 100)
    }
    
    private func prepareFabButton() {
        let button = FabButton(image: Icon.add, tintColor: .white)
        button.pulseColor = .white
        button.backgroundColor = Color.red.base
        self.view.layout(button).width(Button.Fab.diameter).height(Button.Fab.diameter).center(offsetY: 100)
    }
    
    private func prepareRaisedButton() {
        let button = RaisedButton(title: "Raised button", titleColor: Color.white)
        button.pulseColor = .white
        button.backgroundColor = Color.blue.base
        self.view.layout(button).width(Button.Raised.width).height(Button.Raised.height).center(offsetY: Button.Raised.offsetY + 110)
    }
    
    private func prepareNameField() {
        self.nameTextField = TextField()
        self.nameTextField.placeholder = "Name"
        self.nameTextField.detail = "Your given name"
        self.nameTextField.isClearIconButtonEnabled = true
        
        let leftView = UIImageView()
        leftView.image = Icon.phone
        nameTextField.leftView = leftView
        nameTextField.leftViewMode = .always
        view.layout(self.nameTextField).top(4 * constant).horizontally(left: constant, right: constant)
    }
    
    private func  prepareEmailField() {
        self.emailTextField = ErrorTextField(frame: CGRect(x: constant, y: 7 * constant, width: view.width - (2 * constant), height: constant))
        self.emailTextField.placeholder = "Email"
        self.emailTextField.detail = "Error, incorrect Email"
        self.emailTextField.isClearIconButtonEnabled = true
        self.emailTextField.delegate = self
        
        let leftView = UIImageView()
        leftView.image = Icon.email
        
        self.emailTextField.leftViewMode = .always
        self.emailTextField.leftViewNormalColor = .brown
        self.emailTextField.leftViewActiveColor = .green
        self.view.addSubview(self.emailTextField)
    }
    
    private func preparePasswordTextField() {
        self.passwordTextField = TextField()
        self.passwordTextField.placeholder = "PassWord"
        self.passwordTextField.detail = "at least 8 characters"
        self.passwordTextField.clearButtonMode = .whileEditing
        self.passwordTextField.isVisibilityIconButtonEnabled = true
        
        self.passwordTextField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(self.passwordTextField.isSecureTextEntry ? 0.38 : 0.54)
        self.view.layout(self.passwordTextField).top(10 * constant).horizontally(left: constant, right: constant)
    }
    
    private func prepareToolbar() {
        guard let toolbar = toolbarController?.toolbar else {
            return
        }
        
        toolbar.title = "Material"
        toolbar.titleLabel.textColor = .white
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detail = "Build Beautiful Software"
        toolbar.detailLabel.textColor = .white
        toolbar.detailLabel.textAlignment = .left
        
    }
    
}

