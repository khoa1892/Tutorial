//
//  LoginViewController.swift
//  SnapChatClone
//
//  Created by Khoa on 11/11/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: RoundTextField!
    @IBOutlet weak var passwordTextField: RoundTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if let email = self.emailTextField.text, let pass = self.passwordTextField.text, (email.characters.count > 0 && pass.characters.count > 0) {
            AuthService.instance.login(email: email, password: pass, onCompletion: { (errMsg, data) in
                guard errMsg == nil else {
                    let alert = UIAlertController(title: "ErrorAuthenticate", message: errMsg, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            let alert = UIAlertController(title: "Username and Password is required", message: "You must enter both", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func loginFBBtnPressed(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self, handler: { (result, error) in
            if error == nil {
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        })
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                let alert = UIAlertController(title: "Unable to authenticate", message: "Try Again", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
}
