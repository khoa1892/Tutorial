//
//  AuthService.swift
//  SnapChatClone
//
//  Created by Khoa on 11/11/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ errorMsg: String?, _ data: Any?) -> ()

class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onCompletion: @escaping Completion) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let nsError = error as? NSError {
                if let errorCode = FIRAuthErrorCode(rawValue: nsError.code) {
                    if errorCode == FIRAuthErrorCode.errorCodeUserNotFound {
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.handleFirebaseError(error: error as! NSError, onComplete: onCompletion)
                            } else {
                                if user?.uid != nil {
                                    DataService.instance.saveUser(uid: user!.uid)
                                    //Sign In
                                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            self.handleFirebaseError(error: error as! NSError, onComplete: onCompletion)
                                        } else {
                                            onCompletion(nil, user)
                                        }
                                    })
                                }
                            }
                        })
                    }
                } else {
                    self.handleFirebaseError(error: error as! NSError, onComplete: onCompletion)
                }
            } else {
                onCompletion(nil, user)
            }
        })
    }
    
    func handleFirebaseError(error: NSError, onComplete: Completion) {
        if let errorCode = FIRAuthErrorCode(rawValue: error.code) {
            switch errorCode {
            case .errorCodeInvalidEmail:
                onComplete("Invalid email", nil)
                break
            case .errorCodeWrongPassword:
                onComplete("Invalid password", nil)
                break
            case .errorCodeEmailAlreadyInUse, .errorCodeAccountExistsWithDifferentCredential:
                onComplete("Could not create account. Email already in use", nil)
                break
            default:
                onComplete("There was proble Authenticate", nil)
            }
        }
    }
    
}
