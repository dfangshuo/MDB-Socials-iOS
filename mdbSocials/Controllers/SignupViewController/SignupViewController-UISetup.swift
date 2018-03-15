//
//  SignupViewController.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit

extension SignupViewController {
    
    /*************************************************************************************************/
    /************************************ SETUP LAYOUT ***********************************************/
    /*************************************************************************************************/
    
    func setupScroll() {
        scrollView = UIScrollView(frame:CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width + 300)
        view.addSubview(scrollView)
    }
    
    func setupLayout() {
        
        ppDisplay = UIImageView(frame: CGRect(x:(view.frame.width-157)/2, y: 60 - 8, width: 157, height: 157))
        scrollView.addSubview(ppDisplay)
        
        addPP = UIButton(frame: CGRect(x:(view.frame.width-157)/2, y: 0.85*60 - 8, width: 157, height: 0.7*157))
        addPP.setTitle("Add a Profile Pic", for: .normal)
        addPP.clipsToBounds = true
        addPP.addTarget(self, action: #selector(pickPP), for: .touchUpInside)
        addPP.layer.cornerRadius = 10
        addPP.backgroundColor = Constants.appColor
        scrollView.addSubview(addPP)
        
        nLabel = UILabel(frame: CGRect(x: 16, y: 0.85*220 - 8, width: UIScreen.main.bounds.width - 20, height: 0.7*40))
        nLabel.text = "Full Name"
        nLabel.textColor = Constants.appTxt
        nLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        nLabel.font = nLabel.font.withSize(19)
        scrollView.addSubview(nLabel)
        
        nameTextField = UITextField(frame: CGRect(x: 10, y: 0.85*261 - 8, width: UIScreen.main.bounds.width - 20, height: 0.7*40))
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.layer.cornerRadius = 10
        nameTextField.placeholder = "  Full Name"
        nameTextField.layer.borderColor = Constants.appColor.cgColor
        nameTextField.layer.borderWidth = 1.3
        nameTextField.textColor = Constants.appColor
        scrollView.addSubview(nameTextField)
        
        uLabel = UILabel(frame: CGRect(x: 16, y: 0.85*306 - 8, width: UIScreen.main.bounds.width - 20, height: 0.7*40))
        uLabel.text = "Email"
        uLabel.textColor = Constants.appTxt
        uLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        uLabel.font = uLabel.font.withSize(19)
        scrollView.addSubview(uLabel)
        
        emailTextField = UITextField(frame: CGRect(x: 10, y: 0.85*345 - 8, width: UIScreen.main.bounds.width - 20, height: 0.7*40))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.layer.cornerRadius = 10
        emailTextField.placeholder = "  Enter email"
        emailTextField.layer.borderColor = Constants.appColor.cgColor
        emailTextField.layer.borderWidth = 1.3
        emailTextField.textColor = Constants.appColor
        scrollView.addSubview(emailTextField)
        
        iLabel = UILabel(frame: CGRect(x: 16, y: 0.85*388 - 8, width: UIScreen.main.bounds.width - 20, height: 0.7*40))
        iLabel.text = "Username"
        iLabel.textColor = Constants.appTxt
        iLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        iLabel.font = iLabel.font.withSize(19)
        scrollView.addSubview(iLabel)
        
        unameTextField = UITextField(frame: CGRect(x: 10, y: 0.85*425 - 8, width: UIScreen.main.bounds.width - 20, height: 0.7*40))
        unameTextField.adjustsFontSizeToFitWidth = true
        unameTextField.layer.cornerRadius = 10
        unameTextField.placeholder = "  Enter Username"
        unameTextField.layer.borderColor = Constants.appColor.cgColor
        unameTextField.layer.borderWidth = 1.3
        unameTextField.textColor = Constants.appColor
        scrollView.addSubview(unameTextField)
        
        pLabel = UILabel(frame: CGRect(x: 16, y: 0.85*470 - 8, width: UIScreen.main.bounds.width - 20, height: 0.7*40))
        pLabel.text = "Password"
        pLabel.textColor = Constants.appTxt
        pLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        pLabel.font = pLabel.font.withSize(18)
        scrollView.addSubview(pLabel)
        
        passwordTextField = UITextField(frame: CGRect(x: 10, y: 0.85*505 - 8, width: UIScreen.main.bounds.width - 20, height: 0.7*40))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.placeholder = "  Password"
        passwordTextField.layer.borderColor = Constants.appColor.cgColor
        passwordTextField.layer.borderWidth = 1.3
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = Constants.appColor
        passwordTextField.isSecureTextEntry = true
        scrollView.addSubview(passwordTextField)
        
        repeatTextField = UITextField(frame: CGRect(x: 10, y: 0.85*553-8 - 8, width: UIScreen.main.bounds.width - 20, height: 0.7*40))
        repeatTextField.adjustsFontSizeToFitWidth = true
        repeatTextField.layer.cornerRadius = 10
        repeatTextField.placeholder = "  Confirm Password"
        repeatTextField.layer.borderColor = Constants.appColor.cgColor
        repeatTextField.layer.borderWidth = 1.3
        repeatTextField.layer.masksToBounds = true
        repeatTextField.textColor = Constants.appColor
        repeatTextField.isSecureTextEntry = true
        scrollView.addSubview(repeatTextField)
        
        signupButton = UIButton(frame: CGRect(x: 10, y: 0.85*598 - 8, width: UIScreen.main.bounds.width - 20, height: 0.7*50))
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.layer.cornerRadius = 10
        signupButton.backgroundColor = Constants.appColor
        signupButton.layer.masksToBounds = true
        signupButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        scrollView.addSubview(signupButton)
        
        cancel = UIButton(frame:CGRect(x: (view.frame.width - 125)/2, y: 0.85*675 - 8, width: 125, height: 0.7*30))
        cancel.setTitleColor(Constants.appColor, for: .normal)
        cancel.setTitle("back", for: .normal)
        cancel.addTarget(self, action: #selector(toLogin), for: .touchUpInside)
        scrollView.addSubview(cancel)
    }
}

