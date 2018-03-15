//
//  LoginViewController.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit

extension LoginViewController {
    
    /*************************************************************************************************/
    /************************************ SET UP LAYOUT **********************************************/
    /*************************************************************************************************/
    
    func setupImage() {
        imageView = UIImageView(frame: CGRect(x: (view.frame.width-0.7*277)/2, y: 0.7*67, width: 0.7*277, height: 0.7*277))
        imageView.image = #imageLiteral(resourceName: "MDB Cover")
        view.addSubview(imageView)
    }
    
    func setupTextFields() {
        
        uLabel = UILabel(frame: CGRect(x: 0.7*16, y: 0.7*348, width: 0.7*UIScreen.main.bounds.width - 0.7*20, height: 0.7*40))
        uLabel.text = "Email"
        uLabel.textColor = Constants.appTxt
        uLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        uLabel.font = uLabel.font.withSize(19)
        view.addSubview(uLabel)
        
        emailTextField = UITextField(frame: CGRect(x: 0.7*10, y: 0.7*385, width: UIScreen.main.bounds.width - 0.7*20, height: 0.7*40))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.layer.cornerRadius = 10
        emailTextField.becomeFirstResponder()
        emailTextField.placeholder = "  Enter email"
        emailTextField.layer.borderColor = Constants.appColor.cgColor
        emailTextField.layer.borderWidth = 1.3
        emailTextField.textColor = Constants.appColor
        self.view.addSubview(emailTextField)
        
        pLabel = UILabel(frame: CGRect(x: 0.7*16, y: 0.7*430, width: UIScreen.main.bounds.width - 0.7*20, height: 0.7*40))
        pLabel.text = "Password"
        pLabel.textColor = Constants.appTxt
        pLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        pLabel.font = pLabel.font.withSize(18)
        view.addSubview(pLabel)
        
        passwordTextField = UITextField(frame: CGRect(x: 0.7*10, y: 0.7*465, width: UIScreen.main.bounds.width - 0.7*20, height: 0.7*40))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.placeholder = "  Password"
        passwordTextField.layer.borderColor = Constants.appColor.cgColor
        passwordTextField.layer.borderWidth = 1.3
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = Constants.appColor
        passwordTextField.isSecureTextEntry = true
        self.view.addSubview(passwordTextField)
    }
    
    func setupButtons() {
        login = UIButton(frame: CGRect(x: 0.7*10, y: 0.7*535, width: UIScreen.main.bounds.width - 0.7*20, height: 0.7*50))
        login.layer.cornerRadius = 10
        login.setTitle("Login", for: .normal)
        login.backgroundColor = Constants.appColor
        login.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        
        
        noAcc = UILabel(frame: CGRect(x: 0.7*13, y: 0.7*591, width: 0.7*UIScreen.main.bounds.width - 0.7*20, height: 0.7*40))
        noAcc.text = "No account?"
        noAcc.textColor = Constants.appTxt
        noAcc.font = noAcc.font.withSize(18)
        view.addSubview(noAcc)
        
        signup = UIButton(frame:CGRect(x: (view.frame.width - 0.7*125)/2 - 7, y: 0.7*597, width: 125, height: 0.7*30))
        signup.setTitleColor(Constants.appColor, for: .normal)
        signup.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        signup.setTitle("Sign up here", for: .normal)
        signup.addTarget(self, action: #selector(toSignUp), for: .touchUpInside)
        
        view.addSubview(login)
        view.addSubview(signup)
    }
    
}

