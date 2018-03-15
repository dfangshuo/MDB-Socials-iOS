//
//  LoginViewController.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // UI Elements
    var imageView: UIImageView!
    var noAcc: UILabel!
    var uLabel: UILabel!
    var pLabel: UILabel!
    
    // Email & Password
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    
    // Login and Signup Buttons
    var login: UIButton!
    var signup: UIButton!
    
    // user model
    var loginUser: Users!
    var alert: UIAlertController!

    
    // checks if the user is logged in or not
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if FirebaseHelper.currUser() != nil {
            self.performSegue(withIdentifier: "toFeed", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(SignupViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        nc.addObserver(self, selector: #selector(SignupViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        setupImage()
        setupTextFields()
        setupButtons()
        nc.addObserver(self, selector: #selector(errorMsgReceived(_ :)), name: NSNotification.Name(rawValue: "loginError"), object: nil)
        nc.addObserver(self, selector: #selector(errorMsgReceived(_ :)), name: NSNotification.Name(rawValue: "noEmail"), object: nil)
        nc.addObserver(self, selector: #selector(errorMsgReceived(_ :)), name: NSNotification.Name(rawValue: "noPw"), object: nil)
        
    }
    
    /*************************************************************************************************/
    /************************************ BUTTON FUNCTIONS *******************************************/
    /*************************************************************************************************/
    
    @objc func loginPressed() {
        let nc = NotificationCenter.default

        if emailTextField.text! == "" {
            nc.post(name: Notification.Name(rawValue: "noEmail"), object: nil, userInfo: ["errorMsg": "Please enter an email!"])
        } else if passwordTextField.text! == "" {
            nc.post(name: Notification.Name(rawValue: "noPw"), object: nil, userInfo: ["errorMsg": "Please Enter a Password!"])
        } else {
            UserAuthHelper.logIn(email: emailTextField.text!, password:passwordTextField.text!, successAction: {self.performSegue(withIdentifier: "toFeed", sender: self)}, fAction: {
                nc.post(name: Notification.Name(rawValue: "loginError"), object: nil, userInfo: ["errorMsg": "Invalid Username/Password"])
            })

            emailTextField.text = ""
            passwordTextField.text = ""
        }
    }
    
    @objc func toSignUp() {
        self.performSegue(withIdentifier: "toSignUp", sender: self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func errorMsgReceived(_ notification: Notification) {
        alert = UIAlertController(title: "\(notification.userInfo!["errorMsg"]!)", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
