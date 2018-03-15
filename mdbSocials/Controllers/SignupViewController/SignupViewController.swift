//
//  SignupViewController.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import PromiseKit

class SignupViewController: UIViewController {
    
    // navigation
    var cancel: UIButton!
    
    // UI Elements
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var uLabel: UILabel!
    var pLabel: UILabel!
    var nLabel: UILabel!
    var iLabel: UILabel!
    
    // Inut Fields
    var addPP: UIButton!
    let picker = UIImagePickerController()
    var ppDisplay: UIImageView!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var repeatTextField: UITextField!
    var nameTextField: UITextField!
    var unameTextField: UITextField!

    //buttons
    var signupButton: UIButton!

    // saved parameters
    var userDict = [String: Any]();
    
    // user model
    var madeUser = Users()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(SignupViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignupViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(swipeToLogin))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)

        setupScroll()
        setupLayout()
    }
    
    /*************************************************************************************************/
    /************************************ SIGN UP PRESSED FN *****************************************/
    /*************************************************************************************************/
    @objc func signUpPressed() {
        //TODO: Implement this method with Firebase!
        
        if nameTextField.text! == "" {
            Utils.throwError(info: "Please key in your name", vc: self)
        } else if emailTextField.text! == "" {
            Utils.throwError(info: "Please enter your email", vc: self)
        } else if unameTextField.text! == "" {
            Utils.throwError(info: "Please key in a username", vc: self)
        } else if passwordTextField.text! == "" {
            Utils.throwError(info: "Please key in a password", vc: self)
        } else if repeatTextField.text! == "" {
            Utils.throwError(info: "Please confirm your password", vc: self)
        } else if (passwordTextField.text! != repeatTextField.text!) {
            Utils.throwError(info: "Passwords don't match!", vc: self)
        } else {
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            userDict["name"] = nameTextField.text!
            userDict["username"] = unameTextField.text!
            
            
            FirebaseHelper.makeUserPicOptional(userModel: madeUser, email: email, password: password, dictOfInfo: userDict, successAction: { self.performSegue(withIdentifier: "signUpToFeed", sender: self)}, failureAction: {Utils.throwError(info: "Please make sure you entered a valid email and your password is longer than 6 characters", vc: self)}).then{(userId) in APIClient.putImageInStorage(img: self.ppDisplay.image, userId: userId)}
        }
    }
    
    @objc func toLogin() {
        self.dismiss(animated: true, completion: {})
    }
    
    @objc func swipeToLogin() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
//        transit().then{(true) -> Void in
//            sleep(1)
//            self.dismiss(animated: false, completion: {})
//        }
        self.dismiss(animated: false, completion: {})
    }
    
    func transit() -> Promise<Bool> {
        return Promise {fulfill, reject in
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            fulfill(true)
        }
    }
    
//    @objc func pickPP(sender: UIButton!) {
//        picker.delegate = self
//        picker.allowsEditing = false
//        picker.sourceType = .photoLibrary
//        self.present(picker, animated: true, completion: nil)
//        let nc = NotificationCenter.default
//        nc.post(name: Notification.Name(rawValue: "profilePicture"), object: nil, userInfo: ["profilePicture": picker])
//    }
    
    
    @objc func pickPP(sender: UIButton!) {
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
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
}
