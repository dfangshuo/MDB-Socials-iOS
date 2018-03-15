//
//  UserAuthHelper.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import Foundation
import FirebaseAuth
import PromiseKit

class UserAuthHelper {
    
    // creates a user
    static func createUser(userModel: Users ,email: String, password: String, dictOfInfo: [String:Any], withBlock1: @escaping () -> (), withBlock2: @escaping () -> ()) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil && user != nil {
                let name = dictOfInfo["name"] as! String
                let username = dictOfInfo["username"] as!String
                
                userModel.name = name
                userModel.id = (user?.uid)!
                log.verbose("User \(email) created!")
                withBlock1()
            }
            else {
                log.error("Error Creating User: \(error.debugDescription)")
                withBlock2()
            }
        })
    }
    
    // log in
    static func logIn(email: String, password: String, successAction: @escaping ()->() , fAction: @escaping ()->()) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                log.verbose("\(email) successfully logged in!")

                successAction()
            }
            else {
                fAction()
                log.error("\(email) error Logging In: \(error.debugDescription)")
            }
        })
    }
    
    // log out
    static func logOut() -> Promise<Bool> {
        return Promise { fulfill, reject in
            let firebaseAuth = Auth.auth()
            do {
                let user = firebaseAuth.currentUser?.displayName
                try firebaseAuth.signOut()
                log.verbose("user has successfully logged out!")
                fulfill(true)
            } catch let signOutError as NSError {
                log.error("Error signing out: \(signOutError)")
            }
        }
    }
}

