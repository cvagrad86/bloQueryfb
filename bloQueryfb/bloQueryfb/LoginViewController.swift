//
//  LoginViewController.swift
//  bloQueryfb
//
//  Created by Eric Chamberlin on 2/14/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
        
        // MARK: Constants
        let LoginToList = "LoginToList"
        
        // MARK: Outlets
        @IBOutlet weak var textFieldLoginEmail: UITextField!
        @IBOutlet weak var textFieldLoginPassword: UITextField!
        
        // MARK: Properties
        let ref = Firebase(url: "https://bloquery2fb.firebaseio.com")
        
        // MARK: UIViewController Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        override func viewDidAppear(animated: Bool) {
            super.viewDidAppear(animated)
            
            ref.observeAuthEventWithBlock { (authData) -> Void in
                
                if authData != nil {
                    self.performSegueWithIdentifier(self.LoginToList, sender: nil)
                }
                
            }
        }
        
        // MARK: Actions
        @IBAction func loginDidTouch(sender: AnyObject) {
            
            ref.authUser(textFieldLoginEmail.text, password: textFieldLoginPassword.text, withCompletionBlock: { (error, auth) -> Void in
                
            })
            
        }
        
        @IBAction func signUpDidTouch(sender: AnyObject) {
            let alert = UIAlertController(title: "Register",
                message: "Register",
                preferredStyle: .Alert)
            
            let saveAction = UIAlertAction(title: "Save",
                style: .Default) { (action: UIAlertAction) -> Void in
                    
                    let emailField = alert.textFields![0]
                    let passwordField = alert.textFields![1]
                    
                    self.ref.createUser(emailField.text, password: passwordField.text) { (error: NSError!) in
                        
                        if error == nil {
                            print("successful login")
                            self.ref.authUser(emailField.text, password: passwordField.text, withCompletionBlock: { (error, auth) in
                                
                            })
                        }
                    }
                    
                    
            }
            
            let cancelAction = UIAlertAction(title: "Cancel",
                style: .Default) { (action: UIAlertAction) -> Void in
            }
            
            alert.addTextFieldWithConfigurationHandler {
                (textEmail) -> Void in
                textEmail.placeholder = "Enter your email"
            }
            
            alert.addTextFieldWithConfigurationHandler {
                (textPassword) -> Void in
                textPassword.secureTextEntry = true
                textPassword.placeholder = "Enter your password"
            }
            
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            
            presentViewController(alert,
                animated: true,
                completion: nil)
        }
        
    }


